class Api::TimeslotsController < ActionController::API
  def index
    @timeslots = Timeslot.all
    render json: @timeslots
  end

  def create
    if build_params
      render json: { message: "I am the timeslot controller API and need to be fixed because I am a terrible route" }
    else
      @errors = current_user.errors.full_messages
      render json: @errors
    end
  end

  private
  def build_params
    params[:timeslots].each do |timeslot|
      @timeslot = Timeslot.new(start: timeslot[:start])
      @timeslot.tutor_id = current_user.id
      return false unless @timeslot.save
    end
    true
  end

  def safe_params
    params.permit(:start)
  end
end
