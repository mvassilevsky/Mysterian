class UserMailer < ApplicationMailer

  def invite_email(invited_user)
  	@invited_user = invited_user
    mail(from: "Mysterian", to: @invited_user.email,
         subject: "You've been invited to a murder mystery!")
  end

end
