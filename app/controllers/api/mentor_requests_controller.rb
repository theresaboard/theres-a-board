class Api::MentorRequestsController < SecuredController

  def index
    render json: MentorRequest.where(open: true).to_json
  end

  def update
    MentorRequest.find(params[:id]).close
  end

  def status
    render json: {open: MentorRequest.open_by_user(current_user).size}
  end

  def open
    req = MentorRequest.new(student: current_user)
    if req.save!
      render json: {result: "success"}
      current_user.track_event("opened-request")
    end
  end

  def close
    MentorRequest.close_all_by_user(current_user)
    render json: {result: "success"}
    current_user.track_event("closed-request")
  end

end