class TeamsController < ApplicationController
	before_action :logged_in_user, only: [:create, :show, :destroy, :edit, :update, :new]
	before_action :member_of_team, only: [:destroy, :edit, :update]
  before_action :admin_team, only: [:show]

	def index
		# reject admins
		@teams = Team.where.not(name: 'admins')
	end

	def show
		@team = Team.find(params[:id])
		@members = @team.users.sort_by { |user| user.username }.reverse
	end

  def new
		@team = Team.new
  end
	
	def edit
	end

	def destroy
		@team.destroy
    flash[:success] = "Team deleted and all members removed"
    redirect_to teams_url
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes(team_params)
			if params[:user_ids].present?
				params[:user_ids].each do |user_id|
					@team.users << User.find(user_id)
				end
				flash[:success] = "Users added to the team"
			end
			redirect_to @team
		else
			render "teams/add_members"
		end
	end

	def create
		@team = Team.new(team_params)
		if @team.save
			if params[:user_ids].present?
				params[:user_ids].each do |user_id|
					@team.users << User.find(user_id)
				end
				flash[:success] = @team.name + " created!"
			end
      redirect_to admin_path
		else
			render 'settings/edit'
		end
	end

	def remove_member
		@team = Team.find(params[:team_id])
		@user = User.find(params[:user_id])
		if !current_user.admin?
			flash[:danger] = "You are not authorized to remove members from a team"
			redirect_to @team
		else
			@user.leave_team
			flash[:success] = "Member successfully removed"
			redirect_to @team
		end
	end

	def join
		@team = Team.find(params[:team_id])
		@user = User.find(params[:user_id])
		if admin_user? && @user.join_team(@team)
			flash[:success] = "#{@user.username} added to #{@team.name}"
			redirect_to @team
		else
			flash[:danger] = "You are not authorized to add members to a team"
			redirect_to root_url
		end
	end

	def add_members
		@team = Team.find(params[:team_id])
		@users_without_team = User.where(team_id: nil)
	end

	private
		def team_params
			params.require(:team).permit(:name)
		end

		def member_of_team
			@team = Team.find(params[:id])
			unless current_user.team == @team || current_user.admin?
				flash[:danger] = "Access denied"
				redirect_to root_url
			end
		end

		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end

    def admin_team
      @team = Team.find(params[:id])
      if @team.name == "admins" && !current_user.admin?
        flash[:danger] = "Access denied"
        redirect_to root_url
      end
    end
end
