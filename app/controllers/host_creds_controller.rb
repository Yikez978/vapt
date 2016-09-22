class HostCredsController < ApplicationController
  
  before_action :logged_in_user
  

	#POST   /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_creds(.:format)
	def create
		@host_cred = HostCred.new(host_cred_params)
		@host_cred.engagement_main_id = params[:engagement_main_id]
		if @host_cred.save
			render json: @host_cred, status: :created
		else
			render json: @host_cred.errors.full_messages, status: :unprocessable_entity
		end
	end

	#PUT    /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_creds/:id(.:format)
	def update
		@host_cred = HostCred.find(params[:id])
		respond_to do |format|
			if @host_cred.update_attributes(host_cred_edit_params)
				format.json {respond_with_bip(@host_cred)}
			else
				format.json {respond_with_bip(@host_cred)}
			end
		end
	end

	#DELETE /engagements/:engagement_id/engagement_mains/:engagement_main_id/host_creds/:id(.:format)
	def destroy
		@host_cred = HostCred.find(params[:id])
		@host_cred.destroy

		head :ok
	end

	private

	def host_cred_params
		params.permit(:ip, :pwdump, :password, :description)
	end

	def host_cred_edit_params
		params.require(:host_cred).permit(:ip, :pwdump, :password, :description)
	end
end
