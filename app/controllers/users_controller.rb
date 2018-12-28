class UsersController < ApplicationController
  before_action :load_user, only: :show
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :is_admin, only: :destroy

  def show; end

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_succ"
    else
      flash[:danger] = t ".destroy_failed"
    end
    redirect_to users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_login"
      redirect_to login_path
    end
  end

  def correct_user
    redirect_to(root_path) unless current_user?(@user)
  end

  def is_admin
    redirect_to(root_path) unless current_user.admin?
  end
end
