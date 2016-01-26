class DashboardController < SecuredController
  def index
    @leaderboard = User.leaderboard.take(3)
  end
end
