class Game < ActiveRecord::Base
  belongs_to :game_master, class_name: "User", autosave: true
  has_many :players

  # Example: Game.active.find_by_game_master_id(current_user)
  scope :active, ->() {where('status != "CLOSED"')}
end
