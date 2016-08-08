class EngagementsController < ApplicationController
  require 'ipaddr'

  before_action :logged_in_user
  before_action :restrict_site_wide_engagement, only: [:show, :edit, :update, :destroy]
  before_action :is_engagement_state_pending_and_created_by_current_user?, only: [:edit, :update, :destroy]
  before_action :not_sub_engagement, only: [:edit]

  def index
    @engagements = current_user.engagements
    @user_created_engagements = current_user.user_created_engagements.find_all_except_canceled
  end

  def new
    @engagement = Engagement.new
    @sub_engagement = @engagement.sub_engagements.new
    @engagement_types = EngagementType.all.by_name
    @users = User.all
  end

  def create
    @engagement = current_user.user_created_engagements.new(engagement_params)
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
      if params[:engagement][:ip]
        if params[:engagement][:ip].class == String
          @file_content = params[:engagement][:ip]
        else
          uploaded_file = params[:engagement][:ip]
          @file_content = uploaded_file.read
        end
        ip = Ip.create_new(@file_content, @engagement.id)
      end
      @poc = Poc.create_new(params[:engagement][:poc], @engagement.id)
      @system_admin = SystemAdmin.create_new(params[:engagement][:system_admin], @engagement.id)
      @ocb = Ocb.create_new(params[:engagement][:ocb_number], params[:engagement][:ocb_start_date], @engagement.id)
      params[:engagement][:sub_engagements_attributes].each do |sub_engagement_param|
        unless sub_engagement_param[1]['sub_engagement_name'].blank?
          sub_engagement = SubEngagement.create_new(sub_engagement_param[1], @engagement)
        end
      end
      redirect_to engagements_path
    else
      render 'new'
    end
  end

  def show
    @engagement = Engagement.includes(
      :ocbs, :nmap_reports, :nessus_policies, metasploit_reports: [metasploit_hosts: [metasploit_host_vulns: [:metasploit_refs]]], engagement_mains: [:engagement_main_users]
    ).find(params[:id])
    # @notes = Note.where("engagement_id = ?", params[:id])
    @ocbs = @engagement.ocbs
    @nmap_reports = @engagement.nmap_reports
    @nessus_policies = @engagement.nessus_policies
    @engagement_users = @engagement.users
    @metasploit_reports = @engagement.metasploit_reports
    @metasploit_hosts = MetasploitHost.all.map {|m| [m.metasploit_id, m.name]}
    
    # @nessus_plugins = @engagement.nessus_plugins
    #
    # @nessus_reports = @engagement.nessus_reports
    # @nessus_hosts = @engagement.nessus_hosts
    # unless @nessus_hosts.blank?
    #   @nessus_host_properties = @nessus_hosts.first.host_properties.where.not(name: nil)
    # end
  end

  def edit
    @engagement = Engagement.find(params[:id])
    @sub_engagements = @engagement.children
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
    @sub_engagements = @engagement.children
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
      
      if params[:engagement][:sub_engagements_attributes]
        params[:engagement][:sub_engagements_attributes].each do |sub_engagement_param|
          sub_engagement_attr = sub_engagement_param[1]
          sub_engagement = Engagement.find(sub_engagement_attr["id"])
          sub_engagement.engagement_name = sub_engagement_attr["engagement_name"]
          sub_engagement.save
          
          sub_engagement.ips.destroy_all
          sub_engagement.pocs.destroy_all
          sub_engagement.system_admins.destroy_all
          
          sub_engagement_attr["ip"].split(',').each do |ip_address|
            sub_engagement.ips.create(engagement_id: @engagement.id, ip: ip_address)
          end
          
          sub_engagement_attr["poc"].split(',').each do |poc|
            sub_engagement.pocs.create(engagement_id: @engagement.id, name: poc)
          end
          
          sub_engagement_attr["system_admin"].split(',').each do |system_admin|
            sub_engagement.system_admins.create(engagement_id: @engagement.id, name: system_admin)
          end
        end
      end
      
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

  private

  def engagement_params
    params.require(:engagement).permit(:engagement_name, :engagement_type_id, :ip, :ocb_number, :ocb_start_date, :poc, :system_admin, :start_date, :end_date, :user, :is_creator, sub_engagements_attributes: [:id, :sub_engagement_name, :ip, :poc, :system_admin, :engagement_id, :_destroy])
  end
  
  def not_sub_engagement
    @engagement = Engagement.find(params[:id])
    if @engagement.sub_engagement?
      flash[:danger] = "This is a sub engagement, and can be edited from main engagement page."
  		redirect_to engagement_path(params[:id])
    end
  end
end