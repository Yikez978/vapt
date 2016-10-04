class NmapReportsController < ApplicationController
  # engagement_nmap_nmap_reports 
  # GET /engagements/:engagement_id/nmap/:nmap_id/nmap_reports(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @nmap_report = @engagement.nmap_reports.find(params[:nmap_id])
    
    # check index.js.erb
  end
end
