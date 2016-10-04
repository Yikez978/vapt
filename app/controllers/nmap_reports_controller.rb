class NmapReportsController < ApplicationController
  # GET /engagements/:engagement_id/nmap/:nmap_id/nmap_reports(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @nmap_report = @engagement.nmap_reports.find(params[:nmap_id])
  end
end
