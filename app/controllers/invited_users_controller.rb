class InvitedUsersController < ApplicationController

  # POST /games/:id/invite_user/
  # POST /games/:game_id/characters/:id/invite_user
  def invite_user
    @invited_user = InvitedUser.new(invited_user_params)
    @invited_user.invite_token = Devise.friendly_token(8)
    @game = Game.find(invited_user_params[:game_id])
    if @invited_user.save
      UserMailer.invite_email(@invited_user, @game).deliver_now
      render json: {invited_user_email: @invited_user.email}
    else
      render json: {failure_message: @invited_user.errors.full_messages.join(". ")}
    end
  end

  private
    def invited_user_params
      params.permit(:email, :game_id, :character_id)
    end

end
