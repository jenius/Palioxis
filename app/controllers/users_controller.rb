class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def show; end

  def add_card
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.save_card
  	if @user.save
  		flash[:notice] = "Card Saved!"  
  		redirect_to root_path
  	else
  		flash[:notice] = "There was a problem while saving your card, please contact an admin."
  		render 'add_card'
  	end
  end

end
