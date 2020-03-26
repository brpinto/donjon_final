class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :only_logged_in
  helper_method :current_user, :user_logged_in?

  add_flash_types :success, :error
  Rails.application.routes.default_url_options[:host]= 'http://donjonsetcornichons.fr'

  private

  def only_logged_in
    if !user_logged_in?
      redirect_to new_session_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
    end
  end

  def user_logged_out
    redirect_to notes_path if user_logged_in?
  end

  def user_logged_in?
    !current_user.nil?
  end

  def current_user
    return nil if !session[:auth] || !session[:auth]['id']
    User.current = User.find_by_id(session[:auth]['id'])
  end
end
