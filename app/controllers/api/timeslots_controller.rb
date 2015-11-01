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
      TimeslotMailer.tutor_scheduled(timeslot).deliver_now
      TimeslotMailer.student_scheduled(timeslot).deliver_now
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
