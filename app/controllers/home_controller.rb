class HomeController < ApplicationController
  def index
    redirect_to '/marquee' if current_user
  end
end
