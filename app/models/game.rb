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
#

class Game < ActiveRecord::Base
  validates :owner_id, presence: true

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :characters
  has_many :game_users
  has_many :users, through: :game_users
end
