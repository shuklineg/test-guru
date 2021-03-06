class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: I18n.t('dialogs.you_not_authorized') unless current_user.admin?
  end
end
