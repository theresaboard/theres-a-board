class Api::TimeslotsController < SecuredController
  def index
    @timeslots = Timeslot.all.includes(:tutor, :student)
  end

  def create
    timeslot = Timeslot.new(timeslot_params)
    if timeslot.save
      render plain: { message: "success" }
      intercom_event("created-timeslot")
    else
      render plain: { message: "fail" }
    end
  end

  def update
<<<<<<< 437ae230ffc38c3e698c0ed9cd5936ca28d513ea
    timeslot = Timeslot.find_by(id: safe_params[:id])
    timeslot.student_id = current_user.id
    if timeslot.save
      timeslot.send_tutor_scheduling_email
      timeslot.send_student_scheduling_email
      intercom_event("booked-tutor")
      render plain: { message: 'success' }
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
