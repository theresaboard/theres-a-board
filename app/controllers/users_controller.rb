class UsersController < SecuredController

  def edit
    user = User.find(params[:id])
    if user == current_user
      render "edit"
    else
      redirect '/'
    end
  end

end