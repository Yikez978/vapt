class VulnsReportsController < ApplicationController
  
  before_action :logged_in_user
  before_action :check_if_user_belongs_to_engagement
  
  # GET /engagements/:engagement_id/nessus/:nessu_id/vulns_reports(.:format)
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @nessus_policy = @engagement.nessus_policies.find(params[:nessu_id])
    
    # check index.js.erb
  end
end
