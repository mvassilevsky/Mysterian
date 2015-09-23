# == Schema Information
#
# Table name: character_abilities
#
#  id           :integer          not null, primary key
#  character_id :integer          not null
#  ability_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CharacterAbilityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
