class Api::StatsController < SecuredController
  def index
    top_three = User.joins(:timeslots).select('start < ? AND student_id IS NOT NULL', DateTime.now).group(:tutor_id).order('count_start desc').count('start').first(3)
    @users = top_three.map.with_index { |tutor, idx| [User.find(tutor[0]), tutor[1], idx+1] }
  end
end
