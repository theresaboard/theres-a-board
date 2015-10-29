class User < ActiveRecord::Base
  has_many :timeslots, foreign_key: 'tutor_id'
  has_many :bookings, class_name: 'Timeslot', foreign_key: 'student_id'

  validates :name, presence: true
end
