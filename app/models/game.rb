class Game < ActiveRecord::Base
  belongs_to :game_master, class_name: "User", autosave: true
  has_many :players
end
