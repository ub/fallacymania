require 'rails_helper'

RSpec.describe MarqueeController, :type => :controller do

  describe "GET show" do

    context "when not signed in" do
      it " redirects to sign-in page" do
        get :show
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "when signed in" do
      it "returns http success" do
        pending "TODO: implement sign-in for the context"
        get :show
        expect(response).to be_success
      end
    end
  end

end
