class SharesController < ActionController::Base
  def index
    @shares = Share.all.order(id: :desc).limit(50)
  end
end
