class MetasploitController < ApplicationController
  before_action :logged_in_user
  
  
  def new
    @engagement = Engagement.find(params[:engagement_id])
  end
  
  def create
    @engagement = Engagement.find(params[:engagement_id])
    engagement_file = @engagement.engagement_files.new(user_id: current_user.id, asset: params[:metasploit_file])
    
    if engagement_file.save
      MetasploitWorker.perform_async(engagement_file.id, @engagement.id, current_user.id)
      
      flash.now[:notice] = 'Metasploit file uploaded and will be processed on the background.'      
  		redirect_to engagement_path(@engagement)
    else
			flash.now[:danger] = 'Please select a metasploit file.'
			render 'new'
    end
  end

  def show
    @metasploit_report = MetasploitReport.includes(:metasploit_events, :metasploit_services, :metasploit_credential_cores, :metasploit_module_details, :metasploit_credential_origins, :metasploit_credential_publics, :metasploit_credential_logins, :metasploit_credential_privates, metasploit_hosts: [:metasploit_exploit_attempts, :metasploit_host_notes, :metasploit_host_services, metasploit_host_vulns: [:metasploit_refs]]).find(params[:id])
    @engagement = Engagement.find(params[:engagement_id])
  end
end
