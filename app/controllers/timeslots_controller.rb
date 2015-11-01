class TimeslotsController < SecuredController
  def update
    timeslot = Timeslot.find_by(id: safe_params[:id])
    timeslot.student_id = current_user.id
    if timeslot.save
      TimeslotMailer.tutor_scheduled(timeslot).deliver_now unless timeslot.tutor.email.nil?
      TimeslotMailer.student_scheduled(timeslot).deliver_now unless timeslot.student.email.nil?
      render text: 'success'
    else
      render text: timeslot.errors.full_messages.to_s, status: 422
    end
  end

  def show
    @timeslot = Timeslot.find(params[:id])
    if @timeslot.student_id == current_user.id
      render "student_appt_show"
    elsif @timeslot.tutor_id == current_user.id
      render "tutor_appt_show"
    else
      render "appt_show"
    end
  end

  def delete
    if current_user == @timeslot.tutor && @timeslot.student.nil?
      @timeslot.destroy
      render redirect_to root_path
    else
      render json: {message: 'not the owner of this appointment or this is a booked appointment.'}, status: 422
    end
  end

  private

  def safe_params
    params.permit(:start, :id)
  end
end
