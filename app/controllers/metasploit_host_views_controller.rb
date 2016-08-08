class MetasploitHostViewsController < ApplicationController
	def show
		host = MetasploitHost.find(params[:id])
		engagement_main = EngagementMain.find_by(host: host.address, engagement_id: params[:engagement_id])
		redirect_to engagement_host_path(params[:engagement_id], engagement_main)
	end
end
