class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def after_update_path_for(resource)
    resource.admin? ? admin_tests_path : root_path
  end

  def after_inactive_sign_up_path_for(_resource)
    new_user_session_path
  end
end
