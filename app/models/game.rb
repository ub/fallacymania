class Game < ActiveRecord::Base
  belongs_to :game_master, class_name: "User", autosave: true
  has_many :players
  has_many :rounds

  # Example: Game.active.find_by_game_master_id(current_user)
  scope :active, ->() {where('status != "CLOSED"')}

  # game status is one of the
  # - OPEN
  # - PLAYING
  # - CLOSED

  def self.active_for(user)
     Game.active.find_by_game_master_id(user) ||
     Player.in_active_game.find_by_user_id(user).try(:game)
  end
end
