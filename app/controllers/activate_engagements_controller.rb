# activate_engagement GET    /activate_engagements/:id(.:format)
class ActivateEngagementsController < ApplicationController
  def show
    @engagement = Engagement.find(params[:id])
    @engagement.activate
    @engagement.save!
    render js"$('#active_onhold_engagement_#{@engagement.id}_link').attr('href', '/on_hold_engagements/#{@engagement.id}');
      $('#active_onhold_engagement_#{@engagement.id}_link').text('On Hold');"
  end
end
