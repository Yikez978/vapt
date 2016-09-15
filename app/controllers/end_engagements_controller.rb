class EndEngagementsController < ApplicationController
	before_action :check_if_current_user_created_engagement

	def update
		@engagement.end_date = params["end_engagement_date"]
		@engagement.ended
		@engagement.save(validate: false)
		redirect_to engagement_path(@engagement)
	end

	private

	def check_if_current_user_created_engagement
		@engagement = Engagement.find(params[:id])
		if !@engagement.completed? && @engagement.created_by?(current_user)
			return true
		else
			redirect_to engagement_path(params[:id])
		end
	end
end
