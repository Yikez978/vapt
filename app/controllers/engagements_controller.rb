class EngagementsController < ApplicationController
  require 'ipaddr'

  before_action :logged_in_user
  before_action :is_engagement_state_pending_and_created_by_current_user?, only: [:edit, :update, :destroy]

  def complete
    @engagement = current_user.engagements.find(params[:id])
    @engagement.ended
    @engagement.save!
    redirect_to :engagements
  end

  def index
    @engagements = Engagement.where(aasm_state: [:pending, :active] )
    @user_completed_engagements = current_user.engagements.where(aasm_state: :completed)
  end

  def new
    @engagement = Engagement.new
    @engagement_types = EngagementType.all.by_name
    @users = User.all
  end

  def create
    @engagement = current_user.user_created_engagements.new(engagement_params)
    @engagement.customer = Customer.find_or_initialize_by(name: params[:engagement][:customer]) if params[:engagement][:customer].present?
    @engagement_types = EngagementType.all.by_name
    @users = User.all

    if params[:engagement][:engagement_type]
      engagement_type = EngagementType.new
      engagement_type.name = params[:engagement][:engagement_type]
      engagement_type.save
      @engagement.engagement_type_id = engagement_type.id
    end

    if @engagement.save
      if params[:engagement][:user]
        params[:engagement][:user].each do |user|
          @user = User.find_by_username(user)
          unless @user.blank?
            @user_engagement = UserEngagement.new
            @user_engagement.user_id = @user.id
            @user_engagement.engagement_id = @engagement.id
            @user_engagement.save
          end
        end
      end

      if params[:engagement][:ip_file]
        uploaded_file = params[:engagement][:ip_file]
        @file_content = uploaded_file.read
        ip = Ip.create_new(@file_content, @engagement.id)
      end

      if params[:engagement][:ip]
        @file_content = params[:engagement][:ip]
        ip = Ip.create_new(@file_content, @engagement.id)
      end

      @poc = Poc.create_new(params[:engagement][:poc], @engagement.id)
      @system_admin = SystemAdmin.create_new(params[:engagement][:system_admin], @engagement.id)
      @ocb = Ocb.create_new(params[:engagement][:ocb_number], params[:engagement][:ocb_start_date], @engagement.id)

      redirect_to engagements_path
    else
      render 'new'
    end
  end

  def download
    data = []
    data << 'IP, Reference_name, Value'
    nessus_hosts = Risu::Models::Host.where(user_id: current_user.id, engagement_id: params[:id])

    nessus_references = nessus_hosts.
        joins('LEFT JOIN nessus_items ON nessus_hosts.id = nessus_items.host_id').
        joins('LEFT JOIN nessus_plugins ON nessus_items.plugin_id = nessus_plugins.id').
        joins('LEFT JOIN nessus_references ON nessus_references.plugin_id = nessus_plugins.id').where('nessus_references.reference_name IN (?)', ['iava', 'iavb']).
        select("nessus_hosts.*, nessus_items.*, nessus_plugins.*, nessus_references.*")

    nessus_references.group('ip').each do |row|
      data << "#{row.ip}, #{row.reference_name}, #{row.value}"
    end

    send_data data.join("\n"), type: 'text', filename: 'test.csv'
  end

  def ivas
    @engagement = Engagement.find(params[:id])
  end

  def show
    @engagement = Engagement.includes(
      :ocbs,
      :nmap_reports,
      :nessus_policies,
      metasploit_reports: [metasploit_hosts: [metasploit_host_vulns: [:metasploit_refs]]],
      engagement_mains: [:engagement_main_users]
    ).find(params[:id])

    unless @engagement.users.include? current_user
      flash[:success] = "You need to join the engagement before entering!"
      redirect_to request.referer
    end

    @ocbs = @engagement.ocbs
    @nmap_reports = @engagement.nmap_reports
    @nessus_policies = @engagement.nessus_policies
    @engagement_users = @engagement.users
    @metasploit_reports = @engagement.metasploit_reports
    @metasploit_hosts = MetasploitHost.all.map {|m| [m.metasploit_id, m.name]}
  end

  def edit
    @engagement = Engagement.find(params[:id])
    @engagement_types = EngagementType.all.by_name
    @users = User.all

    @poc_names_engagement = @engagement.pocs.where(sub_engagement_id: nil).map {|poc| poc.name}
    @system_admin_names_engagement = @engagement.system_admins.where(sub_engagement_id: nil).map {|system_admin| system_admin.name}
    @engagement_ips = @engagement.ips.where(sub_engagement_id: nil).map{|ip| ip.ip}
    @engagement_user_usernames = @engagement.users.map{|u| u.username}
    @ocb_start_date = @engagement.ocbs.first.start_date
  end

  def update
    @engagement = Engagement.find(params[:id])
    @engagement_types = EngagementType.all.by_name
    @users = User.all

    @poc_names_engagement = @engagement.pocs.where(sub_engagement_id: nil).map {|poc| poc.name}
    @system_admin_names_engagement = @engagement.system_admins.where(sub_engagement_id: nil).map {|system_admin| system_admin.name}
    @engagement_ips = @engagement.ips.where(sub_engagement_id: nil).map{|ip| ip.ip}
    @engagement_user_usernames = @engagement.users.map{|u| u.username}
    @ocb_start_date = @engagement.ocbs.first.start_date

    if @engagement.update_attributes(engagement_params)
      if params[:engagement][:engagement_type]
        engagement_type = EngagementType.create(name: params[:engagement][:engagement_type])
        @engagement.engagement_type_id = engagement_type.id
        @engagement.save
      end
      if params[:engagement][:ip]
        @engagement.ips.destroy_all
        if params[:engagement][:ip].class == String
          @file_content = params[:engagement][:ip]
        else
          uploaded_file = params[:engagement][:ip]
          @file_content = uploaded_file.read
        end
        Ip.create_new(@file_content, @engagement.id)
      end
      if params[:engagement][:user]
        @engagement.users.destroy_all
        params[:engagement][:user].each do |user|
          @user = User.find_by_username(user)
          unless @user.blank?
            @engagement.user_engagements.create(user_id: @user.id)
          end
        end
      end
      @engagement.pocs.destroy_all
      @poc = Poc.create_new(params[:engagement][:poc], @engagement.id)
      @engagement.system_admins.destroy_all
      @system_admin = SystemAdmin.create_new(params[:engagement][:system_admin], @engagement.id)

      redirect_to engagement_path(@engagement)
    else
      render 'edit'
    end
  end

  def destroy
    @engagement = Engagement.find(params[:id])
    @engagement.canceled
    @engagement.save
    redirect_to engagements_path
  end

  def vul_details
    raise 'ok'
  end

  private

  def engagement_params
    params.require(:engagement).permit(:engagement_name, :engagement_type_id, :ip, :ocb_number, :ocb_start_date, :poc, :system_admin, :start_date, :end_date, :user, :is_creator)
  end
end
