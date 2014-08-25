include Warden::Test::Helpers
Warden.test_mode!

# Feature: Game creation
#    As a []signed-in] user
#    I want to create a new game
#    Becoming the game master of it
feature 'Game creation' do

  after(:each) do
    Warden.test_reset!
  end

  let(:user) { FactoryGirl.create(:user) }

  # Scenario: User initiates creation of a new game
  #   Given I am singed in
  #   When I visit marquee page
  #   And click 'Create new game' button
  #   I see new_game form to fill and submit

  scenario 'User initiates creation of a new game' do
    login_as(user)
    visit marquee_path
    click_on 'Create new game'
    expect(page).to have_content 'New Game'
    expect(current_url).to eq( new_game_url)
  end

  # Scenario: User creates a new game
  #   Given I am singed in
  #   When I visit marquee page
  #   Then click 'Create new game' button
  #   And then fill in game description
  #   And then click 'Create Game' button
  #   Finally, I will see edit_game page (as a master)
  #   And game with me as game master will become available

  scenario 'User initiates creation of a new game' do
    login_as(user)
    visit marquee_path
    click_on 'Create new game'
    fill_in 'Description', with: 'Test-game'
    click_on 'Create Game'
    game=Game.find_by_description('Test-game')
    expect(game.game_master).to eq(user)
    expect(current_url).to eq( edit_game_url(game)) #FIXME: this fails!
  end


end