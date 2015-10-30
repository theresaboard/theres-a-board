class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
    render json: @timeslots
  end

  def create
    if build_params
      status 200
    else
      @errors = @timeslot.errors.full_messages
      render json: @errors
    end
  end

  private
  def build_params
    params[:timeslots].each do |timeslot|
      @timeslot = Timeslot.new(safe_params)
      @timeslot.tutor_id = current_user.id
      return false unless @timeslot.save
    end
    true
  end

  def safe_params
    params.require(:timeslot).permit(:start)
  end
end
