# == Schema Information
#
# Table name: invited_users
#
#  id           :integer          not null, primary key
#  email        :string           not null
#  invite_token :string           not null
#  game_id      :integer
#  character_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class InvitedUser < ActiveRecord::Base
	validates :email, uniqueness: { scope: :game_id, message: "already invited" },
									  presence: true
	validates :invite_token, presence: true
	validates :character_id, presence: true, if: "game_id.nil?"
	validates :game_id, presence: true

	belongs_to :character

	def game
		game_id.nil? ? character.game : Game.find(game_id)
	end

end
