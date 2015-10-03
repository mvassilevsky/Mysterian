class UserMailer < ApplicationMailer

  def invite_email(user, game, character)
    @user = user
    @game = game
    @character = character
    mail(from: "localhost", to: user.email,
         subject: "You've been invited to a murder mystery!")
  end

end
