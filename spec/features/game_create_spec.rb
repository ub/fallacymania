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

  # Scenario: User starts creating a new game
  #   Given I am singed in
  #   When I visit marquee page
  #   And press 'Create new game' button
  #   I see new_game form to fill and submit

  scenario 'User starts creating a new game' do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit marquee_path
    click_on 'Create new game'
    expect(page).to have_content 'New Game'
  end
end