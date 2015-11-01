class Api::TimeslotsController < SecuredController
  def index
    @timeslots = Timeslot.all
  end

  def create
    timeslot = Timeslot.new(safe_params)
    timeslot.tutor_id = current_user.id
    if timeslot.save
      render json: { message: 'post api timeslot' }
    else
      @errors = current_user.errors.full_messages
      render json: @errors
    end
  end

  def update
    timeslot = Timeslot.find_by(id: safe_params[:id])
    timeslot.student_id = current_user.id
    if timeslot.save
      timeslot.send_tutor_scheduling_email
      timeslot.send_student_scheduling_email
      render plain: { message: 'success' }
    else
      render plain: { message: 'fail' }
    end
  end

  private
  def safe_params
    params.require(:timeslot).permit(:start, :id, :onsite)
  end
end
