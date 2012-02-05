class UsersController < ApplicationController

  before_filter :introduction
  
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

    @user = current_user

    # If the user already has a card, edit it. If not, create a new one.
    if current_user.stripe_token?
      edited = @user.edit_card(params[:stripe_token])
      edited ? flash[:notice] = "Card updated successfully" : flash[:notice] = "Error! Oh noes!"
    else
      @user.add_new_card(params[:stripe_token])
      @user.save ? flash[:notice] = "Card added successfully" : flash[:notice] = "Error! Oh noes!"
    end

    redirect_to @user

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
