class SessionsController < ApplicationController
  def new

  end

  def create
    user_params = User.find(params[:id])
    @user = User.where('confirmed = 1 AND (username = :username OR email = :username)', username: user_params[:username])
    if @user and user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to root_path, success: "Connexion réussie."
    else
      redirect_to login_path, error: "Identifiants incorrects."
    end
  end

  def destroy

  end
end
