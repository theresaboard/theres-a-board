class TimeslotsController < ApplicationController
  def new
    @timeslot = Timeslot.new
  end

  def build_timeslots
    @timeslots = []
    params[:timeslots].each.with_index do |timeslot, idx|
      @timeslots << Timeslot.new(safe_params)
      @timeslots[idx].tutor_id = current_user.id
    end
  end

  def create
    if @timeslots.save
      render json: @timeslots
    else
      @errors = current_user.errors.full_messages
      render json: @errors
    end
  end

  def safe_params
    params.require(:timeslot).permit(:start, :tutor_id)
  end
end
