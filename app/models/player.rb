class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  #Example: Player.in_active_game_by_user_id(current_user).try(:game)
  scope :in_active_game_by_user_id, -> (user_id_) {joins(:game).where("`games`.status != 'CLOSED'").find_by_user_id(user_id)}

  #Example: Player.in_active_game.find_by_user_id(current_user).try(:game)
  scope :in_active_game, -> () {joins(:game).where("`games`.status != 'CLOSED'")}

end
