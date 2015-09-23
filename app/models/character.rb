# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Character < ActiveRecord::Base
  validates :game_id, presence: true
end
