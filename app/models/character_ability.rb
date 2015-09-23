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

class CharacterAbility < ActiveRecord::Base
  validates :character_id, :ability_id, presence: true
end
