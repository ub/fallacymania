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

  scenario "Game creator watches players joining Test Game", js: true do
    login_as(user)
    visit game_players_path(game)

    expect(current_path).to eq game_players_path(game)

    Capybara.using_session(:alice) do
      page.driver.open_new_window
      login_as(alice)
      visit new_game_player_path(game)
      fill_in 'Nick', with: 'Liddell'
      click_on 'Create Player'
      expect(page).to have_content 'Player has joined the game'
    end
    Capybara.using_session(:bob) do
      page.driver.open_new_window
      login_as(bob)
      visit game_players_path(game)
      expect(page).to have_content('Liddell')
      page.execute_script "window.close();"
    end

    #visit current_path #FIXME: refresh
    expect(current_path).to eq game_players_path(game)

    # see fork solution which may be useful:
    # http://www.coderexception.com/CzbH6mHmUUPWSJSU/multithreaded-concurrent-capybara-requests

    #$stderr.puts 'console log:'
    #$stderr.puts '============'
    #$stderr.puts page.driver.console_messages.to_yaml #FIXME: debug
    #$stderr.puts 'console error:'
    #$stderr.puts '=============='
    #$stderr.puts page.driver.error_messages.to_yaml #FIXME: debug

    #page.find('td', text: 'Liddell')
    #
    expect(page).to have_content('Liddell')


  end


end
