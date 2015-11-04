class MentorController < SecuredController
  before_action :redirect_if_not_mentor

  def index
  end

  private

  def redirect_if_not_logged_in
    unless current_user.is_mentor?
      redirect_to '/login'
    end
  end
end