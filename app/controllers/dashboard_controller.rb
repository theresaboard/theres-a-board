class DashboardController < SecuredController
  def index
    @message = current_user.name
  end

end
