class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  private

  def current_user
    return nil if !session[:auth] || !session[:auth]['id']
    return @_user if @_user
    @_user = User.find_by_id(session[:auth]['id'])
  end
end
