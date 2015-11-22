class InvitedUsersController < ApplicationController

  # POST /games/:game_id/invite_user/
  # POST /games/:game_id/characters/:character_id/invite_user
  def invite_user
    @game = Game.find(invited_user_params[:game_id])
    if invited_user_params[:email] == @game.owner.email
      render json: { failure_message: "You can't be a player in your own game" }
    elsif @game.users.where(email: invited_user_params[:email]).any?
      render json: { failure_message:
                     invited_user_params[:email] + " has already accepted their invitation" }
    else
      @invited_user = InvitedUser.new(invited_user_params)
      @invited_user.invite_token = Devise.friendly_token(8)
      if @invited_user.save
        UserMailer.invite_email(@invited_user, @game).deliver_now
        character = @invited_user.character
        if character?
          if character.invited_user?
            old_invited_user = character.invited_user
            old_invited_user.character_id = nil
            old_invited_user.save
          end
        end
        render json: { invited_user_email: @invited_user.email }
      else
        render json: { failure_message:
                       @invited_user.errors.full_messages.join(". ") }
      end
    end
  end

  private
    def invited_user_params
      params.permit(:email, :game_id, :character_id)
    end

end
