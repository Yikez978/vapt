class EngagementStatusesController < ApplicationController
	def accept
		@user_engagement = UserEngagement.find_or_create_by(user_id: current_user.id, engagement_id: params[:id])

		if @user_engagement.save
			flash[:success] = "You have successfully joined the engagement!"
			respond_to do |format|
				format.html { redirect_to request.referer }
				format.json { render json: { data: {} } }
			end
		end
	end

	def destroy
		@engagement = Engagement.find(params[:id])

		if @engagement.users.count == 1 && @engagement.users.first == current_user
			flash[:success] = "You can't leave the engagement until someone else joins it!"
		else
			@user_engagement = UserEngagement.find_by_user_id_and_engagement_id(current_user.id, @engagement.id)

			if @user_engagement.present?
				@user_engagement.destroy
				flash[:success] = "You have left the engagement successfully!"
			else
				flash[:success] = "You are not a part of this engagement!"
			end
		end
		respond_to do |format|
			format.html { redirect_to request.referer }
			format.json { render json: { data: {} } }
		end
	end
end
