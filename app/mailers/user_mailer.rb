class UserMailer < ApplicationMailer

  def invite_email(user)
    @user = user
    @url = "www.test.com"
    mail(from: "localhost",
         to: user.email,
         subject: "You've been invited to a murder mystery!")
  end

end
