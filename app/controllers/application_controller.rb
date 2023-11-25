class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :update_allowed_paramaters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
  end
end
