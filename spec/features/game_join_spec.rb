include Warden::Test::Helpers
Warden.test_mode!

# Feature: Game joining
#    As a [signed-in] user
#    I want to join an existing game
feature 'Game joining' do

  after(:each) do
    Warden.test_reset!
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:alice) { FactoryGirl.create(:alice) }
  let!(:game)  { FactoryGirl.create(:game, game_master: user)}


  context 'As the game master' do
    before do
      login_as(user)
      visit edit_game_path(game)
    end


    # Scenario: 'User looks at the game he has created'
    #   Given I am signed in
    #   And there exists an OPEN game created by me
    #   When I visit edit_game page
    #   I see 'Join' button
    scenario 'User looks at the game' do
      expect(page).to have_link "Join"
    end

    # Scenario: 'User joins the game he has created'
    #  (1)
    #   Given I am signed in
    #   And there exists an OPEN game created by me
    #   When I visit edit_game page
    #   And click the 'Join' button
    #   Then I am redirected to new game player page
    #  (2)
    #  On new game player page
    #  When I fill nick field
    #  And click the 'Create Player' button
    #  Then i should return to edit_game_page
    scenario 'User joins the game' do
      click_on "Join"
      expect(current_url).to eq new_game_player_url(game)
      fill_in "Nick", with: "the game master"
      click_on "Create Player"   #TODO: relabel as join the game
      expect(current_url).to eq edit_game_url(game)
    end
  end

  context 'As an ordinary user' do
    before do
      login_as(alice)
      visit marquee_path
    end

    # Scenario: 'User joins the game'
    #  (1)
    #   Given I am signed in
    #   And there exists an OPEN game created by other user
    #   When I visit marquee page
    #   And click the 'Join' button
    #   Then I am redirected to new game player page
    #  (2)
    #  On new game player page
    #  When I fill nick field
    #  And click the 'Create Player' button
    #  Then i should be redirected to show game page
    scenario 'User joins the game' do
      click_on "Join"
      expect(current_url).to eq new_game_player_url(game)
      fill_in "Nick", with: "liddell"
      click_on "Create Player"   #TODO: relabel as join the game
      expect(current_url).to eq game_url(game)
    end
  end

  scenario 'User is not allowed to join more than one game' #TODO
  scenario 'Game master is not allowed to games other than his own' #TODO

  scenario 'User nick should be unique' #TODO


end