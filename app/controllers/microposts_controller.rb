class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :set_user, only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @feed_items = current_user.feed.paginate(page: params[:page]).per_page(10)

    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      flash.now[:danger] = "Unable to created the micropost"
      #@feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted."
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  def set_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
