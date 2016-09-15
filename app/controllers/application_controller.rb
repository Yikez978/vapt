class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	include SessionsHelper
	include SettingsHelper
  
  def is_engagement_state_pending_and_created_by_current_user?
  	engagement = Engagement.find(params[:id])
  	unless engagement.pending? || engagement.created_by?(current_user)
      flash[:danger] = "Not authorized to change this engagement."
  		redirect_to engagement_path(params[:id])
  	end
  end
  
  def restrict_site_wide_engagement
    engagement = Engagement.find(params[:id])
    if engagement.is_site_wide_engagement
      flash[:danger] = "This is a site wide engagement, please use proper URL."
  		redirect_to site_wide_engagement_path(params[:id])
    end
  end
  
  def restrict_normal_engagement
    engagement = Engagement.find(params[:id])
    if !engagement.is_site_wide_engagement
      flash[:danger] = "This is a normal engagement, please use proper URL."
  		redirect_to engagement_path(params[:id])
    end
  end
  
  # This is for those nested routes derived from engagement
  def check_if_user_belongs_to_engagement
    user = Engagement.find(params[:engagement_id]).users.where(id: current_user).first
    logger.info"*************#{user}************"
    unless user
      flash[:danger] = "Not authorized."
  		redirect_to root_path
    end
  end
  
  # URL routes override
  def edit_engagement_path(engagement_id)
    engagement = Engagement.find(engagement_id)
    
    if engagement.is_site_wide_engagement
      edit_site_wide_engagement_url(engagement.id)
    else
      edit_engagement_url(engagement.id)
    end
  end
  
  def engagement_path(engagement_id)
    engagement = Engagement.find(engagement_id)
    
    if engagement.is_site_wide_engagement
      site_wide_engagement_url(engagement.id)
    else
      engagement_url(engagement.id)
    end
  end
  
  helper_method :edit_engagement_path, :engagement_path

  private
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end
  
	def admin_user
    unless current_user.admin?
			store_location
			flash[:danger] = "Access Denied."
			redirect_to root_url
		end
  end
end
