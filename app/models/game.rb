# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  validates :owner_id, presence: true

end
