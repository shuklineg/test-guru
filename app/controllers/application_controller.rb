class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :set_locale

  protected

  def set_locale
    available = I18n.available_locales.map(&:to_s).include?(params[:locale])
    I18n.locale = available ? params[:locale] : I18n.default_locale
  end

  def default_url_options
    options = {}
    options[:locale] = I18n.locale unless I18n.default_locale == I18n.locale
    options
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = I18n.t('user.hello', name: resource.fullname) unless resource.fullname.blank?

    resource.admin? ? admin_tests_path : session['user_return_to'] || root_path
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
