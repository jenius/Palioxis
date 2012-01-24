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

  def donate

  end

  def charge_card
    if current_user.stripe_token
      Stripe::Charge.create(
        :amount => params[:amount].to_i,
        :currency => "usd",
        :customer => Stripe::Customer.retrieve(current_user.stripe_token),
        :description => "Donation to Jeff, aw yeah"
      )
      flash[:notice] = "Great success! I now have all your monies!"
      render 'donate'
    else
      flash[:notice] = "You haven't added a card yet!"
      render 'donate'
    end

  end

end
