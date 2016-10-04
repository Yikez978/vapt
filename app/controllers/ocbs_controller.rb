class OcbsController < ApplicationController
  protect_from_forgery except: [:create]
  
  before_action :logged_in_user
  
  # POST   /engagements/:engagement_id/ocbs(.:format)
  def create
    ocb_existing = Ocb.find(params[:id]) if params[:id]


    if ocb_existing
      ocb_existing.update_attributes(ocb_params) ?
          render json: ocb_existing, status: :ok :
          render json: ocb_existing.errors, status: :unprocessable_entity
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