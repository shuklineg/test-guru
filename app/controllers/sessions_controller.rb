class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if cookies[:redirect_form]
        redirect_from = cookies[:redirect_form]
        cookies.delete(:redirect_form)
        redirect_to redirect_from
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = t('.login_error')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
