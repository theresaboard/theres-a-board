class Api::TimeslotsController < SecuredController
  def index
    if params[:search] == 'ALL'
      @timeslots = Timeslot.current(params)
    elsif params[:search] == 'AVAILABLE'
      @timeslots = Timeslot.available(params)
    elsif params[:search] == 'MINE'
      @timeslots = Timeslot.owned_by_current_user(params, current_user)
    end
  end

  def create
    timeslot = Timeslot.new(timeslot_params)
    timeslot.tutor_id = current_user.id
    if timeslot.save
      render json: { status: "success" }
      current_user.track_event("created-timeslot")
    else
      render json: { errors: timeslot.errors.full_messages.join('. ') }, status: 406
    end
  end

  def update
    timeslot = Timeslot.find_by(id: params[:id])
    timeslot.student_id = current_user.id
    timeslot.update_attributes(timeslot_params)
    timeslot.save!
    render plain: { message: 'success' }
    timeslot.send_booking_notifications
    current_user.track_event("booked-tutor")
  end

  def cancel
    timeslot = Timeslot.find_by(id: params[:id])
    student = timeslot.student
    timeslot.student_id = nil
    if (current_user.id == timeslot.tutor.id || current_user.id == student.id) && timeslot.save
      render plain: { message: 'success' }
      timeslot.send_cancel_notifications(student)
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
    params.permit(:start, :subject)
  end
end
