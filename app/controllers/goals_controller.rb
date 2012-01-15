class GoalsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@goals = Goal.all
	end

	def new
		@user = User.find(params[:user_id])
		@goal = @user.goals.new(params[:goal])
	end

	def create
		params[:goal][:state] = :pending
		@user = User.find(params[:user_id])
		@goal = @user.goals.new(params[:goal])
		if @goal.save
			redirect_to user_goals_path(1)
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:user_id])
		@goal = @user.goals.find(params[:id])
	end

	def edit
		@user = User.find(params[:user_id])
		@goal = @user.goals.find(params[:id])
		logger.debug @goal.inspect
	end

	def update
		@user = User.find(params[:user_id])
		@goal = @user.goals.find(params[:id])
		if @goal.update_attributes(params[:goal])
			redirect_to user_goal_path(@user, @goal)
		else
			render "edit"
		end
	end

end
