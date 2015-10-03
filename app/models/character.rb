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
end
