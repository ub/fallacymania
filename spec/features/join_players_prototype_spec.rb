include Warden::Test::Helpers
Warden.test_mode!

feature "Players joining the game" do
  after(:each) do
    Warden.test_reset!
  end

  let(:user)  { FactoryGirl.create(:user) }
  let(:alice) { FactoryGirl.create(:alice) }
  let(:bob)   { FactoryGirl.create(:bob) }
  let(:clare) { FactoryGirl.create(:clare) }
  let(:game)  { FactoryGirl.create(:game, game_master: user)}

  scenario "Game creator watches players joining Test Game" do
    
  end


end
