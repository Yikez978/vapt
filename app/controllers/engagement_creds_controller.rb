class EngagementCredsController < ApplicationController
  
  before_action :logged_in_user
  before_action :check_if_user_belongs_to_engagement
  
  # POST   /engagements/:engagement_id/engagement_creds(.:format)
  def create
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_cred = @engagement.engagement_creds.new(engagement_params)
    
    @engagement_cred.user_id = current_user.id
    # @engagement_cred.engagement_id = @engagement.id
    
    if @engagement_cred.save
      render json: @engagement_cred, status: :created 
    else
      render json: @engagement_cred.errors.full_messages, status: :unprocessable_entity 
    end
  end
  
  # DELETE /engagements/:engagement_id/engagement_creds/:id(.:format)
  def destroy
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_cred = @engagement.engagement_creds.find(params[:id])
    @engagement_cred.destroy

    head :ok
  end

  #GET    /engagements/:engagement_id/engagement_creds(.:format)
  def index
    @engagement_creds = EngagementCred.where(engagement_id: params[:engagement_id])
    respond_to do |format|
      format.csv {send_data @engagement_creds.as_csv}
    end
  end
  
  private

  def engagement_params
    params.permit(:ip, :pwdump, :password, :description)
  end
end
