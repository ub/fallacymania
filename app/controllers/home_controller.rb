class HomeController < ApplicationController
  def index
    redirect_to controller: :marquee, action: :show if current_user
  end
end
