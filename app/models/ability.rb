# == Schema Information
#
# Table name: abilities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ability < ActiveRecord::Base
  validates :name, presence: true
end
