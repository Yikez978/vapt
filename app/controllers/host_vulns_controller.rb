class HostVulnsController < ApplicationController
  
  before_action :logged_in_user
  
	
	#POST   /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_vulns(.:format)
	def create
		@host_vuln = HostVuln.new(host_vuln_params)
		@host_vuln.engagement_main_id = params[:engagement_main_id]
		if @host_vuln.save
			render json: @host_vuln, status: :created
		else
			render json: @host_vuln.errors.full_messages, status: :unprocessable_entity
		end
	end

	#PUT    /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_vulns/:id(.:format)
	def update
		@host_vuln = HostVuln.find(params[:id])
		respond_to do |format|
			if @host_vuln.update_attributes(host_vuln_edit_params)
				format.json {respond_with_bip(@host_vuln)}
			else
				format.json {respond_with_bip(@host_vuln)}
			end
		end
	end

	#DELETE /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_vulns/:id(.:format)
	def destroy
		@host_vuln = HostVuln.find(params[:id])
		@host_vuln.destroy

		head :ok
	end

	private

	def host_vuln_params
		params.permit(:port, :aasm_state, :level_of_access, :severity, :cve, :cwe, :synopsis, :vuln_name)
	end

	def host_vuln_edit_params
		params.require(:host_vuln).permit(:port, :aasm_state, :level_of_access, :vuln_name)
	end
end
