# == Schema Information
#
# Table name: characters
#
#  id              :integer          not null, primary key
#  game_id         :integer          not null
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string           not null
#  character_sheet :text
#

class Character < ActiveRecord::Base
  validates :game_id, presence: true

  belongs_to :game
  belongs_to :user

  attr_accessor :player_email #necessary for character creation form

  #necessary for best_in_place updating
  def display_player_email
    user.email unless user.nil?
  end
end
