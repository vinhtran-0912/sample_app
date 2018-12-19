class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      check_rememember user
      redirect_to user
    else
      flash.now[:danger] = t ".error_messages"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout_messages"
    redirect_to root_path
  end

  def check_rememember user
    if params[:session][:remember_me] == Settings.session_controller.remember_1
      remember user
    else
      forget user
    end
  end
end
