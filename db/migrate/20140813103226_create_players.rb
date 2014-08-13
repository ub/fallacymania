class CreatePlayers < ActiveRecord::Migration
  def change

    create_table :players do |t|
      t.references :user, index: true
      t.string :nick
      t.integer :score
      t.references :game, index: true

      t.timestamps
    end
  end
end
