class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :description
      t.string :status, limit: 10, default: "OPEN" # OPEN/PLAYING/CLOSED
      t.references :game_master, index: true

      t.timestamps
    end
  end
end
