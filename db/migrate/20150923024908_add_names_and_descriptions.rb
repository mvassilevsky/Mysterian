class AddNamesAndDescriptions < ActiveRecord::Migration
  def change
    add_column :games, :name, :string, null: false
    add_column :games, :description, :text
    add_column :characters, :name, :string, null: false
    add_column :characters, :character_sheet, :text
  end
end
