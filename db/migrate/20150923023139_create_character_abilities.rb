class CreateCharacterAbilities < ActiveRecord::Migration
  def change
    create_table :character_abilities do |t|
      t.integer :character_id, null: false
      t.integer :ability_id, null: false

      t.timestamps null: false
    end
  end
end
