class EngagementMainUsersController < ApplicationController
  layout false
  
  before_action :logged_in_user
  
  
  # GET    /engagements/:engagement_id/engagement_mains/:engagement_main_id/engagement_main_users(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_main = @engagement.engagement_mains.find(params[:engagement_main_id])
    @engagement_users = @engagement.users
    @engagement_main_users = @engagement_main.engagement_main_users
    @existing_user_ids = @engagement_main_users.map {|emu| emu.user_id}
  end
  
  # POST   /engagements/:engagement_id/engagement_mains/:engagement_main_id/engagement_main_users(.:format)
  def create
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_main = @engagement.engagement_mains.find(params[:engagement_main_id])
    @engagement_main_users = @engagement_main.engagement_main_users
    @users = User.find(params[:user_ids])
    
    @engagement_main.engagement_main_users.destroy_all if @users
    
    @users.each do |user|
      @engagement_main.engagement_main_users.create(user_id: user.id)
    end
  end
  
end