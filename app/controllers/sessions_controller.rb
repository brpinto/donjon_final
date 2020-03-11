class SessionsController < ApplicationController

  skip_before_action :only_logged_in, only: [:new, :create]
  before_action :user_logged_out, only: [:new, :create]

  def new
  end

  def create
    user_params = params.require(:user)
    @user = User.where('confirmed = 1 AND (username = :username OR email = :username)', username: user_params[:username]).first
    if @user and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to root_path, success: "Connexion réussie."
    else
      redirect_to login_path, error: "Identifiants incorrects."
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: "Vous êtes deconnecté"
  end
end
