module GamesHelper

  def display_game_master( game )
    if i_am_the_game_master(game)
      "you"
    else
      game.game_master.name
    end
  end

  def i_am_the_game_master(game)
    game.game_master == current_user
  end

  def display_game_creation_time( game )
    game.created_at.to_formatted_s(:time)
  end
end
