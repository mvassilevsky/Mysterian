class InvitedUser < ActiveRecord::Base
	validates :email, presence: true
	validates :invite_token, presence: true
	validates :character_id, presence: true, if: "game_id.nil?"
	validates :game_id, presence: true, if: "character_id.nil?"

	belongs_to :character

	def game
		game_id.nil? ? character.game : Game.find(game_id) 
	end


end
