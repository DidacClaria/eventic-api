class UserEmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_email_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    print "password_reset-------------------------------------------------------------"
    print @user.email
    mail :to => user.email, :subject => "Password reset"
  end
end
