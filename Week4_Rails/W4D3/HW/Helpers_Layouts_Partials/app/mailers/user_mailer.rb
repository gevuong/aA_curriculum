class UserMailer < ApplicationMailer
  default from: 'from@example'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/session/new'
    mail(to: user.username, subject: 'Welcome to My Awesome Site')
  end

  def reminder_email(user)
  end

end
