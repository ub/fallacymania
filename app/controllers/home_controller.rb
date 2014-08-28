class HomeController < ApplicationController
  def index
    redirect_to marquee_path if current_user
  end
end
