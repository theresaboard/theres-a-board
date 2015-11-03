class Api::TimeslotsController < SecuredController
  def index
    @timeslots = Timeslot.all.includes(:tutor, :student).where('start >= ? AND start <= ?', params[:start], params[:end])
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
    timeslot = Timeslot.find_by(id: params[:id])
    timeslot.student_id = current_user.id
    timeslot.save!
    render plain: { message: 'success' }
    timeslot.send_tutor_scheduling_email
    timeslot.send_student_scheduling_email
    current_user.track_event("booked-tutor")
  end

  def cancel
    timeslot = Timeslot.find_by(id: params[:id])
    student = timeslot.student
    timeslot.student_id = nil
    if (current_user.id == timeslot.tutor.id || current_user.id == student.id) && timeslot.save
      timeslot.send_tutor_cancel_email(student)
      timeslot.send_student_cancel_email(student)
      render plain: { message: 'success' }
    else
      render plain: { message: 'fail' }
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    if current_user == @timeslot.tutor && @timeslot.student.nil?
      @timeslot.destroy
      render plain: { message: 'success' }
    else
      render plain: { message: 'fail' }
    end
  end

  private

  def timeslot_params
    params.permit(:start).merge(tutor_id: current_user.id)
  end
end
