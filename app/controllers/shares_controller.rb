class SharesController < SecuredController
  def index
    @shares = Share.all.order(id: :desc).limit(50)
  end

  def new
    @share = Share.new
    render "/shares/new"
  end

  def create
    share = Share.new(share_params)
    share.user = current_user
    if share.save
      render plain: { message: 'success' }
    else
      render plain: { message: 'fail' }
    end
  end

  def share_params
    params.require(:share).permit(:url, :title, :description, :category)
  end
end
