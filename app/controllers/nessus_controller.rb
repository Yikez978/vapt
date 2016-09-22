class NessusController < ApplicationController
  
  before_action :logged_in_user
  
  
	def new
	end

	def create
	  engagement = Engagement.find(params[:engagement_id])
    engagement_file = engagement.engagement_files.new(user_id: current_user.id, asset: params[:nessus_file])
    
    if engagement_file.save
      NessusWorker.perform_async(engagement_file.id, engagement.id, current_user.id)
      
      flash.now[:notice] = 'Nessus file uploaded and will be processed on the background.'      
  		redirect_to engagement_path(engagement)
    else
			flash.now[:danger] = 'Please select a nessus file.'
			render 'new'
    end
    
    
    # system "risu #{params[:nessus_file].tempfile.path} #{current_user.id} #{params[:engagement_id]}"
    # system "cd ../.."
    
    # output = []
    # IO.popen("risu --config-file #{Rails.root.to_s}/risu.cfg #{params[:nessus_file].tempfile.path} #{current_user.id} #{params[:engagement_id]}").each do |line|
    #   output << line.chomp
    # end
    #
    # @nessus_policy = Risu::Models::Policy.where(engagement_id: params[:engagement_id], user_id: current_user.id).order("id DESC").first || Risu::Models::Policy.first
    #
    # # nessus_hosts = @nessus_policy.nessus_reports.map {|r| r.hosts}.flatten
    # em = PopulateEngagementMain.new(@nessus_policy, current_user.id, params[:engagement_id])
    # em.populate
    
    # redirect_to engagement_nessu_path(params[:engagement_id], @nessus_policy.id)
	end

	def show
		@nessus_policies = Policy.includes(:family_selections, :individual_plugin_selections, :plugins_preferences, :server_preferences, nessus_reports: [hosts: [:host_properties, :items]]).where(engagement_id: params[:engagement_id])
		@plugins = Plugin.includes(:references).all
    @engagement = Engagement.find(params[:engagement_id])
	end
end
