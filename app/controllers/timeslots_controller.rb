class TimeslotsController < SecuredController
  def show
    @timeslot = Timeslot.find(params[:id])
    render '/timeslots/show'
  end

  def update
    @timeslot = Timeslot.find_by(id: safe_params[:id])
    @timeslot.student_id = current_user.id
    if @timeslot.save
      render text: 'success'
    else
      @errors = @timeslot.errors.full_messages
      render text: @errors.to_s, status: 422
    end
  end

  def show
    @timeslot = Timeslot.find(params[:id])
    render '/timeslots/show'
  end

  private

  def safe_params
    params.permit(:start, :id)
  end
end
