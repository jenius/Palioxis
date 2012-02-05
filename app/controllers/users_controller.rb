class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def add_card
    @user = User.find(params[:id])
  end

  def manage_card; end

  def edit_card

    customer = Stripe::Customer.retrieve(current_user.stripe_token)
    customer.card = params[:stripe_token]

    customer.save ? flash[:notice] = "Card updated successfully" : flash[:notice] = "Error! Oh noes!"
    redirect_to current_user

  end

  # this has to go. should be merged into the edit card method
  def update
    current_user.save_card
    if current_user.save
      flash[:notice] = "Card Saved!"  
      redirect_to current_user
    else
      flash[:notice] = "There was a problem while saving your card, please contact an admin."
      render 'add_card'
    end
  end

  def donate; end

  def charge_card
    if current_user.stripe_token
      Stripe::Charge.create(
        :amount => params[:amount].to_i,
        :currency => "usd",
        :customer => Stripe::Customer.retrieve(current_user.stripe_token),
        :description => "Donation from #{current_user.email}"
      )
      flash[:notice] = "Great success! I now have all your monies!"
      render 'donate'
    else
      flash[:notice] = "You haven't added a card yet!"
      render 'donate'
    end

  end

end
