class OcbsController < ApplicationController
  protect_from_forgery except: [:create]
  
  before_action :logged_in_user
  
  
  # engagement_ocbs_path
  # {"number":"sadsad","start_date":"2016-04-18T18:30:00.000Z"}
  
  # POST   /engagements/:engagement_id/ocbs(.:format)
  def create
    ocb_existing = Ocb.find(params[:id]) if params[:id]
    engagement = Engagement.find(params[:engagement_id])
    
    if ocb_existing
      if ocb_existing.update_attributes(ocb_params)
        # 'Ocb was successfully updated.'
        render json: ocb_existing, status: :ok
      else
        render json: ocb_existing.errors, status: :unprocessable_entity
      end
    else
      ocb = Ocb.new(ocb_params)
      if ocb.save
        # 'Ocb was successfully created.'
        render json: ocb, status: :created
      else
        render json: ocb.errors, status: :unprocessable_entity
      end
    end
  end
  
  private
  
  def ocb_params
    params.permit(:number, :start_date, :id, :engagement_id)
  end
end