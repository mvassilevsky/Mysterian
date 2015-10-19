class CharacterAbilitiesController < ApplicationController
  # POST /abilities/add
  def add_character_ability
    @character_ability = CharacterAbility.create(character_id: params[:character_id],
                                                 ability_id: params[:ability_id])
    render json: {character_ability_id: @character_ability.id}
  end

  # DELETE /abilities/:id
  def delete_character_ability
    CharacterAbility.delete(params[:id])
    render nothing: true
  end
end
