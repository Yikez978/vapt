class EngagementStatusesController < ApplicationController
	def accept
		@user_engagement = UserEngagement.find_or_create_by(user_id: current_user.id, engagement_id: params[:engagement_id])
		if @user_engagement.save
			respond_to do |format|
				format.json {render json: {data: @user_engagement}}
			end
		end
	end

	def destroy
		@engagement = UserEngagement.find_by_user_id_and_engagement_id(current_user.id, params[:id])
		@engagement.destroy
		respond_to do |format|
			format.html {redirect_to request.referer}
			format.json {render json: {data: {}}}
		end
	end
end
