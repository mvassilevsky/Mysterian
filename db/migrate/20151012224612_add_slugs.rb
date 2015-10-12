class AddSlugs < ActiveRecord::Migration
  def change
    add_column :characters, :slug, :string, null: false
    add_column :games, :slug, :string, null: false
  end
end
