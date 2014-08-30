class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds, id: false do |t|
      t.integer :ordinal
      t.references :game
      t.string :workflow_state

      t.timestamps
    end
    add_index :rounds, [:game_id, :ordinal]
  end
end
