class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :game_id, null: false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
