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
#  slug            :string           not null
#

class Character < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :game_id, presence: true
  validates :name, uniqueness: { scope: :game_id }, presence: true

  belongs_to :game
  belongs_to :user
  has_one :invited_user
  has_many :character_abilities
  has_many :abilities, through: :character_abilities

  attr_accessor :player_email #necessary for character creation form

  #necessary for best_in_place updating
  def display_player_email
    user.email unless user.nil?
  end

  def slug_candidates
    [:name]
  end
end
