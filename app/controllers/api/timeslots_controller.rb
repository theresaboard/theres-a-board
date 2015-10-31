class Api::TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
  end

  def create
    if build_params
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
      render json: { message: 'success' }
    else
      @errors = @timeslot.errors.full_messages
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
    params.permit(:start, :id)
  end
end
