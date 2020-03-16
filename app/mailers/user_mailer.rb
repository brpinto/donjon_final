class UserMailer < ApplicationMailer
  def confirm(user)
    @user = user

    mail(to: user.email, subject: 'Votre inscription sur ' + Rails.application.config.site[:name])
  end

  def password(user)
    @user = user

    mail(to: user.email, subject: 'Changement de votre mot de passe pour ' + Rails.application.config.site[:name])
  end
end