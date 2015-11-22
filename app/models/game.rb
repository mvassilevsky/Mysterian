# == Schema Information
#
# Table name: games
#
#  id          :integer          not null, primary key
#  owner_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           not null
#  description :text
#  slug        :string           not null
#

class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :characters
  has_many :game_users
  has_many :users, through: :game_users
  has_many :invited_users

  def slug_candidates
    [
      :name,
      [:name, owner.display_name]
    ]
  end
end
