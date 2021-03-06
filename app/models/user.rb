class User < ActiveRecord::Base
  has_many :timeslots, foreign_key: 'tutor_id'
  has_many :bookings, class_name: 'Timeslot', foreign_key: 'student_id'
  has_many :shares
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates_presence_of :name
  validates_inclusion_of :email_notify, in: [true, false], message: "can't be blank"
  validates_inclusion_of :text_notify, in: [true, false], message: "can't be blank"
  validates_presence_of :cellphone, message: "must be present for text notifications", if: 'text_notify'

   # Returns an array of Users (*not* an ActiveRecord::Relation):
   # [User, recent bookings count]
  def self.leaderboard
    timeslot_leaders = Timeslot.leaderboard
    user_leaders = User.where(id: timeslot_leaders.map { |el| el[0] })
    user_leaders.zip(timeslot_leaders.map { |el| el[1] }, (1..10).to_a)
  end

  def completed_count
    self.timeslots.booked.count(:id)
  end

  def cellphone=(cellphone_number)
    write_attribute(:cellphone, cellphone_number.gsub(/\D/, '')) unless cellphone_number.nil?
  end

  def track_event(event_name, options={})
    attributes = {:event_name => event_name, :email => self.email, :user_id => self.id}
    attributes[:created_at] = options[:created_at] || Time.now.to_i
    attributes[:metadata] = options[:metadata] unless options[:metadata].nil?
    Event.create(attributes)
  end

  def is_mentor?
    self.roles.include?(Role.find_by(name: "mentor"))
  end
end
