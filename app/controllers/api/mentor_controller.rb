class Api::MentorController < MentorController

  def index
    render json: MentorRequest.where(open: true).to_json
  end

  def update
    MentorRequest.find(params[:id]).close
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