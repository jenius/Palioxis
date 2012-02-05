class UsersController < ApplicationController

  before_filter :introduction
  
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_username(params[:username])
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
      @user.save ? flash[:notice] = "Card added successfully" : flash[:notice] = "There was a problem adding your card."
    end

    redirect_to @user

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated"
    else
      flash[:notice] = "There was an error updating your profile"
    end
    redirect_to profile_path(@user.username)
  end

  def donate; end

  def charge_card
    
    if current_user.stripe_token
      current_user.charge_card(params[:amount])
      flash[:notice] = "Great success! I now have all your monies!"
    else
      flash[:notice] = "You haven't added a card yet!"
    end

    render 'donate'

  end

end
