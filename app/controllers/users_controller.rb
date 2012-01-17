class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def show; end

  def add_card
  	@user = User.find(params[:id])
  end

  def edit_card
	customer = Stripe::Customer.retrieve(current_user.stripe_token)
	customer.card = params[:stripe_token]
	customer.save
	flash[:notice] = "Card changed successfully"
	render 'add_card'
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
