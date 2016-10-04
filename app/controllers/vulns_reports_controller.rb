class VulnsReportsController < ApplicationController
  
  before_action :logged_in_user

  # GET /engagements/:engagement_id/nessus/:nessu_id/vulns_reports(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @nessus_policy = @engagement.nessus_policies.find(params[:nessus_id])
  end
end
