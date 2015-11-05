class Api::UsersController < SecuredController
  def update
    if current_user.update(user_params)
      render plain: { message: 'success' }
      current_user.track_event('updated profile')
    else
      render json: { errors: current_user.errors.full_messages.join('. ') }, status: 406
    end
  end

  private

  def user_params
    params.permit(:email_notify, :text_notify, :cellphone)
  end
end
