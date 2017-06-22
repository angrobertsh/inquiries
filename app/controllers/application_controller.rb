class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def reset_flash_errors
    flash[:errors] ||= {}
  end

end
