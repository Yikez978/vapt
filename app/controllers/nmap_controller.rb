class NmapController < ApplicationController
  before_action :logged_in_user
  before_action :check_if_user_belongs_to_engagement
  
  # GET    /engagements/:engagement_id/nmap/new(.:format)
	def new
    @engagement = Engagement.find(params[:engagement_id])
	end

  # POST   /engagements/:engagement_id/nmap(.:format)
	def create
	  engagement = Engagement.find(params[:engagement_id])
    engagement_file = engagement.engagement_files.new(user_id: current_user.id, asset: params[:file])
    
	  if engagement_file.save
      NmapWorker.perform_async(engagement_file.id, engagement.id, current_user.id)
      
      flash.now[:notice] = 'Nmap uploaded and will be processed on the background.'      
			redirect_to engagement_path(engagement)
		else
			flash.now[:danger] = 'Please select a nmap file.'
			render 'new'
		end
	end

	def index
		@nmap_reports = NmapReport.where(user_id: current_user.id)
	end

	def show
		@nmap_report = NmapReport.find(params[:id])
		@nmap_hosts = NmapHost.find_by(nmap_report_id: params[:id])
		@engagement = Engagement.find(params[:engagement_id])
	end
end