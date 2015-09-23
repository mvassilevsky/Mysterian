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

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
