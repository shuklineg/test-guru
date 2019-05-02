class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = I18n.t('user.hello', name: resource.fullname) unless resource.fullname.blank?

    resource.is_a?(Admin) ? admin_tests_path : session['user_return_to'] || root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
