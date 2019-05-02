class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cookies[:redirect_form] || root_path
    else
      flash.now[:alert] = t('.login_error')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  def find_user
    email = params[:email].downcase.strip
    @user = User.find_by(email: email)
  end
end
