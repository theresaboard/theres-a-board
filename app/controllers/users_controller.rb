class UsersController < SecuredController
  def edit
    @user = current_user
    render "edit"
  end
end