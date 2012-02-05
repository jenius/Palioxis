class GoalsController < ApplicationController

  before_filter :authenticate_user!, :introduction

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
    @goal.state = :pending
    
    if @goal.save
      redirect_to user_goals_path(params[:user_id])
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @goal = @user.goals.find(params[:id])
  end

  # these will absolutely be ajax, I promise
  def mark_complete
    @goal = current_user.goals.find(params[:id])
    @goal.state = :completed
    @goal.save
    flash[:notice] = "Goal marked as complete"
    redirect_to root_path
  end

  def mark_failed
    @goal = current_user.goals.find(params[:id])
    @goal.state = :failed
    @goal.save
    flash[:notice] = "Goal marked as failed"
    redirect_to root_path
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
