

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"])
    user.valid?
    #user.perform_validations({})
    if user.persisted?
      flash.notice = "Signed in Through Google!"
      sign_in_and_redirect user
    else
      redirect_to root
    end
  end
end
