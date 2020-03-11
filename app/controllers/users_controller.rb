class UsersController < ApplicationController

  skip_before_action :only_logged_in, only: [:new, :create, :confirm]
  before_action :user_logged_out, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    @user.recover_password = nil

    if @user.valid?
      @user.save
      UserMailer.confirm(@user).deliver_now
      redirect_to login_path, success: "Votre compte a bien été créé vous devriez recevoir un email pour confirmer votre compte."
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    if @user.update(user_params)
      redirect_to profil_path, success: "Vos informations ont bien été mises à jour."
    else
      render 'edit'
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      @user.update_attributes(confirmed: true, confirmation_token: nil)
      @user.save
      session[:auth] = @user.to_session
      redirect_to profil_path, success: "Votre compte a bien été confirmé."
    else
      render 'edit'
    end
  end

end
