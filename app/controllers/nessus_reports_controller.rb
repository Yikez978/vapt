class NessusReportsController < ApplicationController
  # engagement_nessu_nessus_reports 
  # GET /engagements/:engagement_id/nessus/:nessu_id/nessus_reports(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @nessus_policy = @engagement.nessus_policies.find(params[:nessu_id])
    
    # check index.js.erb
  end
end
