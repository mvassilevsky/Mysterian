class CreateInvitedUsers < ActiveRecord::Migration
  def change
    create_table :invited_users do |t|
      t.string :email, null: false
      t.string :invite_token, null: false
      t.integer :game_id
      t.integer :character_id

      t.timestamps null: false
    end
  end
end
