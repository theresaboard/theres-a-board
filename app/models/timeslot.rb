class Timeslot < ActiveRecord::Base
  belongs_to :tutor, class_name: 'User'
  has_one    :student, class_name: 'User'

  validates :start, :tutor_id, presence: true
end
