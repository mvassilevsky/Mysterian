# == Schema Information
#
# Table name: game_users
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  game_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GameUser < ActiveRecord::Base
  validates :user_id, :game_id, presence: true
end
