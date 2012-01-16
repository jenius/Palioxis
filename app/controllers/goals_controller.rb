class GoalsController < ApplicationController

  before_filter :authenticate_user!, :match_user

  def match_user
    if current_user.id.to_i != params[:user_id].to_i
      redirect_to root_path
      flash[:notice] = "You can't edit another user's goals!"
    end
  end

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

    # set state and format date
    params[:goal][:state] = :pending
    params[:goal][:due] = Date.strptime(params[:goal][:due], "%m/%d/%Y")
    
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
