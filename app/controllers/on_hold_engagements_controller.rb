class OnHoldEngagementsController < ApplicationController
  # on_hold_engagement GET    /on_hold_engagements/:id(.:format)
  def show
    @engagement = Engagement.find(params[:id])
    @engagement.hold
    @engagement.save
    
    render js: "
      $('#active_onhold_engagement_#{@engagement.id}_link').attr('href', '/activate_engagements/#{@engagement.id}');
      $('#active_onhold_engagement_#{@engagement.id}_link').text('Activate'); 
    "
  end
end
