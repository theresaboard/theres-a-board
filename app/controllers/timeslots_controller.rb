class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
    render json: @timeslots
  end

  def create
    current_user.timeslots.build(params[:timeslots])
    if current_user.save
      status 200
    else
      @errors = current_user.errors.full_messages
      render json: @errors
    end
  end

  private

  def safe_params
    params.require(:timeslot).permit(:start, :tutor_id)
  end
end
