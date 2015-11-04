class Api::MentorRequestsController < SecuredController

  def status
    render json: {open: MentorRequest.open_by_user(current_user).size}
  end

  def open
    req = MentorRequest.new(student: current_user)
    if req.save!
      render json: {result: "success"}
    end
  end

  def close
    MentorRequest.close_all_by_user(current_user)
    render json: {result: "success"}
  end

end