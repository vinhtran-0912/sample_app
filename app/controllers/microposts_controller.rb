class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to request.referrer || root_path
  end

  private
    def micropost_params
      params.require(:micropost).permit :content, :picture
    end

    def correct_user
      @micropost = current_user.microposts.find_by id: params[:id]
      redirect_to root_path if @micropost.nil?
    end
end
