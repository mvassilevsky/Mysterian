class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
