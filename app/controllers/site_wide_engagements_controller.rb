class SiteWideEngagementsController < ApplicationController
	require 'ipaddr'
  
  before_action :restrict_normal_engagement, only: [:show, :edit, :update, :destroy]
  before_action :is_engagement_state_pending_and_created_by_current_user?, only: [:edit, :update, :destroy]
  
  def index
    @engagements = current_user.engagements.where(is_site_wide_engagement: true)
  end

	def new
		@site_wide_engagement = Engagement.new
		@sub_engagement = @site_wide_engagement.sub_engagements.new
		@site_wide_engagement_types = EngagementType.all.by_name
		@users = User.all
	end

	def create
    @site_wide_engagement = current_user.user_created_engagements.new(engagement_params)
		@site_wide_engagement_types = EngagementType.all.by_name
    @users = User.all
    
    @site_wide_engagement.is_site_wide_engagement = true
    
		if @site_wide_engagement.save
			params[:engagement][:user].each do |user|
				@user = User.find_by_username(user)
				unless @user.blank?
					@user_engagement = UserEngagement.new
					@user_engagement.user_id = @user.id
					@user_engagement.engagement_id = @site_wide_engagement.id
					@user_engagement.save
				end
			end
			if params[:engagement][:ip]
				if params[:engagement][:ip].class == String
					@file_content = params[:engagement][:ip]
				else
					uploaded_file = params[:engagement][:ip]
					@file_content = uploaded_file.read
				end
				ip = Ip.create_new(@file_content, @site_wide_engagement.id)
			end
			@poc = Poc.create_new(params[:engagement][:poc], @site_wide_engagement.id)
			@system_admin = SystemAdmin.create_new(params[:engagement][:system_admin], @site_wide_engagement.id)
			@ocb = Ocb.create_new(params[:engagement][:ocb_number], params[:engagement][:ocb_start_date], @site_wide_engagement.id)
			params[:engagement][:sub_engagements_attributes].each do |sub_engagement_param|
				@site_wide_engagement.sub_engagements.each do |sub_engagement|
					if sub_engagement_param[1]["ip"]
						if sub_engagement_param[1]["ip"].class == String
							@file_content = sub_engagement_param[1]["ip"]
						else
							uploaded_file = sub_engagement_param[1]["ip"]
							@file_content = uploaded_file.read
						end
						ip = Ip.create_new(@file_content, @site_wide_engagement.id, sub_engagement.id)
					end
					@sub_engagement_poc = Poc.create_new(sub_engagement_param[1]["poc"], @site_wide_engagement.id, sub_engagement.id)
					@sub_engagement_system_admin = SystemAdmin.create_new(sub_engagement_param[1]["system_admin"], @site_wide_engagement.id, sub_engagement.id)
				end
			end
			redirect_to engagements_path
		else
			render 'new'
		end
	end
  
	def show
		@site_wide_engagement = Engagement.find(params[:id])
		@notes = Note.where("engagement_id = ?", params[:id])
	end

	def edit
		@site_wide_engagement = Engagement.find(params[:id])
		@engagement_types = EngagementType.all.by_name
		@users = User.all

		@poc_names_engagement = []
    pocs_engagements = @site_wide_engagement.pocs.where(sub_engagement_id: nil)
    pocs_engagements.each do |poc|
      @poc_names_engagement << poc.name
    end

    @poc_names_sub_engagement = []
    pocs_sub_engagements = @site_wide_engagement.pocs.where.not(sub_engagement_id: nil)
    pocs_sub_engagements.each do |poc|
      @poc_names_sub_engagement << poc.name
    end

    @system_admin_names_engagement = []
    system_admins_engagements = @site_wide_engagement.system_admins.where(sub_engagement_id: nil)
    system_admins_engagements.each do |system_admin|
      @system_admin_names_engagement << system_admin.name
    end

    @system_admin_names_sub_engagement = []
    system_admins_sub_engagement = @site_wide_engagement.system_admins.where.not(sub_engagement_id: nil)
    system_admins_sub_engagement.each do |system_admin|
      @system_admin_names_sub_engagement << system_admin.name
    end

    @engagement_ips = @site_wide_engagement.ips.where(sub_engagement_id: nil).map{|ip| ip.ip}
    @sub_engagement_ips = @site_wide_engagement.ips.where.not(sub_engagement_id: nil).map{|ip| ip.ip}
		@engagement_user_usernames = @site_wide_engagement.users.map{|u| u.username}
		@ocb_start_date = @site_wide_engagement.ocbs.first.start_date
	end

	def update
		@site_wide_engagement = Engagement.find(params[:id])
		if @site_wide_engagement.update_attributes(engagement_params)
			if params[:engagement][:ip]
				@site_wide_engagement.ips.destroy_all
				if params[:engagement][:ip].class == String
					@file_content = params[:engagement][:ip]
				else
					uploaded_file = params[:engagement][:ip]
					@file_content = uploaded_file.read
				end
				ip = Ip.create_new(@file_content, @site_wide_engagement.id)
			end
			@site_wide_engagement.users.destroy_all
			if params[:engagement][:user]
				params[:engagement][:user].each do |user|
					@user = User.find_by_username(user)
					unless @user.blank?
						@user_engagement = UserEngagement.new
						@user_engagement.user_id = @user.id
						@user_engagement.engagement_id = @site_wide_engagement.id
						@user_engagement.save
					end
				end
			end
			@site_wide_engagement.pocs.destroy_all
			@poc = Poc.create_new(params[:engagement][:poc], @site_wide_engagement.id)
			@site_wide_engagement.system_admins.destroy_all
			@system_admin = SystemAdmin.create_new(params[:engagement][:system_admin], @site_wide_engagement.id)
			@site_wide_engagement.ocbs.destroy_all
			@ocb = Ocb.create_new(params[:engagement][:ocb_number], params[:engagement][:ocb_start_date], @site_wide_engagement.id)
			params[:engagement][:sub_engagements_attributes].each do |sub_engagement_param|
				@site_wide_engagement.sub_engagements.each do |sub_engagement|
					if sub_engagement_param[1]["ip"]
						if sub_engagement_param[1]["ip"].class == String
							@file_content = sub_engagement_param[1]["ip"]
						else
							uploaded_file = sub_engagement_param[1]["ip"]
							@file_content = uploaded_file.read
						end
						ip = Ip.create_new(@file_content, @site_wide_engagement.id, sub_engagement.id)
					end
					@sub_engagement_poc = Poc.create_new(sub_engagement_param[1]["poc"], @site_wide_engagement.id, sub_engagement.id)
					@sub_engagement_system_admin = SystemAdmin.create_new(sub_engagement_param[1]["system_admin"], @site_wide_engagement.id, sub_engagement.id)
				end
			end
			redirect_to site_wide_engagement_path(@site_wide_engagement.id)
		else
			render 'edit'
		end
	end

	def destroy
		@site_wide_engagement = Engagement.find(params[:id])
		@site_wide_engagement.canceled
		@site_wide_engagement.save
    
		redirect_to engagements_path
	end
  
	private

	def engagement_params
		params.require(:engagement).permit(:engagement_name, :engagement_type_id, :is_site_wide_engagement, :ip, :ocb_number, :ocb_start_date, :poc, :system_admin, :start_date, :end_date, :user, sub_engagements_attributes: [:id, :sub_engagement_name, :ip, :poc, :system_admin, :engagement_id, :_destroy])
	end
end
