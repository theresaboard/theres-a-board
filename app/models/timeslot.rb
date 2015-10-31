class Timeslot < ActiveRecord::Base
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'

  validates :start, :tutor_id, presence: true

  def end
    start + 30.minutes
  end


  def open?
    student.nil?
  end

  def booked_slot
    "#FF5722"
  end

  def open_slot
    "#2196F3"
  end
end
