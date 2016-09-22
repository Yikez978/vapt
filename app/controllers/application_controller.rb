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
