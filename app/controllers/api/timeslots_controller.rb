class Api::TimeslotsController < SecuredController
  def index
    @timeslots = Timeslot.all
  end

  def create
    timeslot = Timeslot.new(start: params[:timeslot])
    timeslot.tutor_id = current_user.id
    if timeslot.save
      render json: { message: "I am the timeslot controller API and need to be fixed because I am a terrible route" }
    else
      @errors = current_user.errors.full_messages
      render json: @errors
    end
  end

  def update
    @timeslot = Timeslot.find_by(id: safe_params[:id])
    @timeslot.student_id = current_user.id
    if @timeslot.save
      render plain: { message: 'success' }
    else
      render plain: { message: 'fail' }
    end
  end

  def delete

  end

  private
  def safe_params
    params.permit(:start, :id)
  end
end
