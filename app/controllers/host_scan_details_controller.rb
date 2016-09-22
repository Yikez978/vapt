class HostScanDetailsController < ApplicationController
  
  before_action :logged_in_user
  
  
  # GET /engagements/:engagement_id/host_scan_details/:id
	def show
		@engagement = Engagement.find(params[:engagement_id])
		@nessus_host = Host.find_by_id_and_engagement_id(params[:id], params[:engagement_id])
		@nessus_host_properties = @nessus_host.host_properties.where.not(name: nil)
	end
end
