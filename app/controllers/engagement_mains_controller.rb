class EngagementMainsController < ApplicationController
  
  before_action :logged_in_user
  before_action :check_if_user_belongs_to_engagement
  
	#POST   /engagements/:engagement_id/engagement_mains(.:format)
	def create
		@engagement = Engagement.find(params[:engagement_id])
    @engagement_main = @engagement.engagement_mains.new(engagement_params)
    
    @engagement_main.user_id = current_user.id
    # @engagement_main.not_exploited
    if @engagement_main.save
      render json: @engagement_main, status: :created 
    else
      render json: @engagement_main.errors.full_messages, status: :unprocessable_entity 
    end
	end

	#DELETE /engagements/:engagement_id/engagement_mains/:id(.:format)
	def destroy
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_main = @engagement.engagement_mains.find(params[:id])
    @engagement_main.destroy

    head :ok
  end

  #PUT    /engagements/:engagement_id/engagement_mains/:id(.:format)
  def update
    @engagement = Engagement.find(params[:engagement_id])
    @engagement_main = @engagement.engagement_mains.find(params[:id])
    respond_to do |format|
      if @engagement_main.update_attributes(engagement_edit_params)
        format.json { respond_with_bip(@engagement_main) }
      else
        format.json { respond_with_bip(@engagement_main) }
      end
    end
  end
  
  private

  def engagement_params
    params.permit(:host, :ports, :services, :vulns, :exploits, :host_name, :purpose, :os)
  end

  def engagement_edit_params
    params.require(:engagement_main).permit(:ports, :services, :vulns, :exploits, :aasm_state, :host, :host_name, :mac, :os)
  end
end
