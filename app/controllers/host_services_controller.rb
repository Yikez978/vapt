class HostServicesController < ApplicationController
	#POST   /engagements/:engagement_id/hosts/:host_id/host_services(.:format)
	def create
		@engagement_main = EngagementMain.find(params[:host_id])
		@host_info = HostInfo.new(host_info_params)
		@host_info.ip = @engagement_main.host
		@host_info.engagement_main_id = @engagement_main.id
		if @host_info.save
			render json: @host_info, status: :created
		else
			render json: @host_info.errors.full_messages, status: :unprocessable_entity 
		end
	end

	#PUT    /engagements/:engagement_id/hosts/:host_id/host_services/:id(.:format)
	def update
		@host_info = HostInfo.find(params[:id])
		respond_to do |format|
      if @host_info.update_attributes(host_info_edit_params)
        format.json { respond_with_bip(@host_info) }
      else
        format.json { respond_with_bip(@host_info) }
      end
    end
	end

	#DELETE /engagements/:engagement_id/hosts/:host_id/host_services/:id(.:format)
	def destroy
		@host_info = HostInfo.find_by_engagement_main_id_and_id(params[:host_id], params[:id])
		@host_info.destroy

		head :ok
	end

	private

	def host_info_params
		params.permit(:service_port, :service_protocol, :service_status, :service_name, :service_banner)
	end

	def host_info_edit_params
		params.require(:host_info).permit(:service_port, :service_protocol, :service_status, :service_name, :service_banner)
	end
end
