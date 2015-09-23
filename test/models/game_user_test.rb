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

require 'test_helper'

class GameUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
