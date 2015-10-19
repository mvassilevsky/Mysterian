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

require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
