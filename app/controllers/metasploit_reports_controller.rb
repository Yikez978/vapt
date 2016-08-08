class MetasploitReportsController < ApplicationController
	# engagement_metasploit_metasploit_reports
  # GET    /engagements/:engagement_id/metasploit/:metasploit_id/metasploit_reports(.:format)               metasploit_reports#index
  def index
    @engagement = Engagement.find(params[:engagement_id])
    @metasploit_report = @engagement.metasploit_reports.find(params[:metasploit_id])
    @metasploit_hosts = MetasploitHost.all.map {|m| [m.metasploit_id, m.name]}
    # check index.js.erb
  end
end
