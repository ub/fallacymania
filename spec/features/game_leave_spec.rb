include Warden::Test::Helpers
Warden.test_mode!

# Feature: Game joining
#    As a game player
#    Given the game is in OPEN state
#    I want to leave a game I've joined
feature 'Game leaving' do

  after(:each) do
    Warden.test_reset!
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:alice) { FactoryGirl.create(:alice) }
  let!(:game)  { FactoryGirl.create(:game, game_master: user)}

  # TODO after leaving the game, game master returns to edit_game page
  context 'As the game master'  do #TODO


  end

  # TODO ordinary user returns to marquee page
  context 'As an ordinary user' do #TODO

  end




end