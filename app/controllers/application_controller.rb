class ApplicationController < ActionController::Base
  protect_from_forgery

  def introduction
    if current_user && !current_user.read_intro?
      redirect_to intro_path
    end
  end
  
end
