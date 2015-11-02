class Api::TimeslotsController < SecuredController
  def index
    @timeslots = Timeslot.all.includes(:tutor, :student)
  end

  def create
    timeslot = Timeslot.new(timeslot_params)
    if timeslot.save
      render plain: { message: "success" }
      current_user.track_event("created-timeslot")
    else
      render plain: { message: "fail" }
    end
  end

  def update
    timeslot = Timeslot.find_by(id: safe_params[:id])
    timeslot.student_id = current_user.id
    if timeslot.save
      render plain: { message: 'success' }
      timeslot.send_tutor_scheduling_email
      timeslot.send_student_scheduling_email
      current_user.track_event("booked-tutor")
    else
      render plain: { message: 'fail' }
    end
  end

  private
  def safe_params
    params.permit(:start, :id)
  end

  def timeslot_params
    params.permit(:start).merge(tutor_id: current_user.id)
  end
end
