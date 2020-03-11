class PasswordsController < ApplicationController

  skip_before_action :only_logged_in
  before_action :user_logged_out

  def new
  end

  def create
    user_params = params.require(:user)
    @user = User.find_by_email(user_params[:email])

    if @user
      @user.regenerate_recover_password
      UserMailer.password(@user).deliver_now
      redirect_to new_session_path, success: "Votre demande de mot de passe a été prise en compte, un mail de confirmation vous a été envoyé."
    else
      redirect_to new_password_path, danger: "Aucun utilisateur ne correspond à cet email"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.recover_password != params[:token]
      redirect_to new_password_path, danger: "Ce token semble invalide"
    end
  end

  def update
    user_params = params.require(:user).permit(:password, :password_confirmation, :recover_password)
    @user = User.find(params[:id])
    if @user.recover_password === user_params[:recover_password]
      @user.assign_attributes(user_params)
      if @user.valid?
        @user.recover_password = nil
        @user.save
        session[:auth] = @user.to_session
        redirect_to notes_path, succes: "Votre mot de passe a été modifié avec succès"
      else
        render :edit, danger: 'oups'
      end
    else
      redirect_to new_password_path, danger: "Ce token semble invalide"
    end
  end
end