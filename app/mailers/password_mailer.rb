class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.password_mail.subject
  #
  def password_mail(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, subject: "Cambio contraseña eventic"
  end
end
