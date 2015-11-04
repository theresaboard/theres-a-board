class Api::UsersController < SecuredController

  def update
    if current_user.update(user_params)
      render plain: { message: 'success' }
      current_user.track_event('updated profile')
    else
      render plain: { message: 'fail' }, status: 422
    end
  end

  private

    def user_params
      params.permit(:email_notify, :text_notify, :cellphone)
    end

end
