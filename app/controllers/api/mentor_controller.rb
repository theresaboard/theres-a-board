class Api::MentorController < MentorController
  def index
    @requests = MentorRequest.where(open: true)
  end

  def close_request
    MentorRequest.find(params[:id]).close
    render json: {status: "success"}
  end

  def status
    render json: {checkedin: AvailableMentor.checked_in?(current_user)}
  end

  def checkin
    req = AvailableMentor.new(mentor: current_user)
    if req.save!
      render json: {result: "success"}
      current_user.track_event("mentor-in")
    end
  end

  def checkout
    AvailableMentor.checkout(current_user)
    render json: {result: "success"}
    current_user.track_event("mentor-out")
  end
end
