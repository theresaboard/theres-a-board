class Api::StatsController < SecuredController
  def index
    @users = User.joins(:timeslots).select('start < ? AND student_id IS NOT NULL', DateTime.now).group(:tutor_id).order('count_start desc').count('start').first(3)
  end
end
