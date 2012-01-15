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
		@user = User.find(params[:user_id])
		@goal = @user.goals.new(params[:goal])
		if @goal.save
			redirect_to user_goals_path(1)
		else
			render 'new'
		end
	end

end
