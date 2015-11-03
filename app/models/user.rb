class User < ActiveRecord::Base
  has_many :timeslots, foreign_key: 'tutor_id'
  has_many :bookings, class_name: 'Timeslot', foreign_key: 'student_id'
  has_many :shares

  validates :name, presence: true

  def track_event(event_name, options={})
    attributes = {:event_name => event_name, :email => self.email, :user_id => self.id}
    attributes[:created_at] = options[:created_at] || Time.now.to_i
    attributes[:metadata] = options[:metadata] unless options[:metadata].nil?
    Event.create(attributes)
  end
end
