class PagesController < ApplicationController

  def intro; end

  def read_intro
    current_user.read_intro = true
    if current_user.save
      redirect_to root_path
    else
      flash[:error] = "Something went horrible wrong. Give it another shot por favor"
      render 'intro'
    end
  end

end
