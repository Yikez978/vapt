class HostsController < ApplicationController
  
  before_action :logged_in_user
  before_action :check_if_user_belongs_to_engagement
  
  # GET    /engagements/:engagement_id/hosts/:id(.:format)
	def show
		@engagement = Engagement.find(params[:engagement_id])
		@engagement_main = EngagementMain.find(params[:id])
		@host_infos = @engagement_main.host_infos
	end
end
