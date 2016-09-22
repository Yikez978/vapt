class CustomFindingsController < ApplicationController
  
  before_action :logged_in_user
  
  
	#POST   /engagements/:engagement_id/engagement_mains/:engagement_main_id/custom_findings(.:format)
	def create
		@custom_finding = CustomFinding.new(custom_finding_params)
		@custom_finding.engagement_main_id = params[:engagement_main_id]
		if @custom_finding.save
			render json: @custom_finding, status: :created
		else
			render json: @custom_finding.errors.full_messages, status: :unprocessable_entity
		end
	end

	#PUT    /engagements/:engagement_id/engagement_mains/:engagement_main_id/custom_findings/:id(.:format)
	def update
		@custom_finding = CustomFinding.find(params[:id])
		respond_to do |format|
			if @custom_finding.update_attributes(custom_finding_edit_params)
				format.json {respond_with_bip(@custom_finding) }
			else
				format.json {respond_with_bip(@custom_finding) }
			end
		end
	end

	#DELETE /engagements/:engagement_id/engagement_mains/:engagement_main_id/custom_findings/:id(.:format)
	def destroy
		@custom_finding = CustomFinding.find(params[:id])
		@custom_finding.destroy

		head :ok
	end

	private

	def custom_finding_params
		params.permit(:host, :port, :service, :severity, :desc, :level_of_access)
	end

	def custom_finding_edit_params
		params.require(:custom_finding).permit(:host, :port, :service, :severity, :desc, :level_of_access)
	end
end
