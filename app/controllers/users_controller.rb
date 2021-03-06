class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :index, :destroy, :edit, :update]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:index, :destroy]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		user = User.find(params[:id])
		#Profile page calendar section start
		@date = params[:month] ? Date.parse(params[:month]) : Date.today
		@user_engagements = user.engagements.where('extract(year from start_date) = ?', @date.year).where('extract(month from start_date) = ?', @date.month)
		#Profile page calender section end
    @engagements = UserEngagement.available_engagements(current_user.id)
    if view_other_profiles? || current_user?(user) || admin_user?
      @user = user
    else
      message  = 'Access Denied'
      message += 'You can only view your profile.'
      flash[:warning] = message
      redirect_to root_url
    end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
      log_in(@user)
      flash[:success] = "Welcome to #{vapt_project}!"
      redirect_to @user
		else
			render 'new'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = 'User Deleted'
		redirect_to users_url
	end

	def edit
		@edit_user_page = true
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = 'Changes saved successfully'
			redirect_to @user
		else
			render 'edit'
		end
	end

	def reset_password
		redirect_to root_path unless current_user.admin?
		user = User.find(params[:id])
		user.password = 'password'
		user.save
		flash[:success] = 'User password has been reset to "password". Please change immediately!'
		redirect_to admin_path
	end

	# This method is used for https://github.com/loopj/jquery-tokeninput/pull/291, to search using AJAX
	def find_users
		@user = User.where('username LIKE ?', "%#{params[:q]}%")
		@user_json = []
		@user.each do |user|
			@user_json << {id: user.id, username: user.username}
		end
		respond_to do |format|
			format.json {render json: @user_json}
		end
	end

	private
	def user_params
		params.require(:user).permit(:fname, :lname, :username, :password, :password_confirmation, :discount_code, :avatar)
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		unless current_user?(@user)
			flash[:danger] = "Access denied"
			redirect_to root_url
		end
	end

	def admin_user
		unless admin_user?
			flash[:danger] = "Access denied"
			redirect_to root_url
		end
		end
end
