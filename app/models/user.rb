class User < ActiveRecord::Base
  has_many :timeslots, foreign_key: 'tutor_id'
  has_many :bookings, class_name: 'Timeslot', foreign_key: 'student_id'
  has_many :shares

  validates_presence_of :name
  validates_inclusion_of :email_notify, in: [true, false], message: "can't be blank"
  validates_inclusion_of :text_notify, in: [true, false], message: "can't be blank"
  validates_presence_of :cellphone, message: "must be present for text notifications", if: 'text_notify'

  def cellphone=(cellphone_number)
    write_attribute(:cellphone, cellphone_number.gsub(/\D/, '')) unless cellphone_number.nil?
  end

  def track_event(event_name, options={})
    attributes = {:event_name => event_name, :email => self.email, :user_id => self.id}
    attributes[:created_at] = options[:created_at] || Time.now.to_i
    attributes[:metadata] = options[:metadata] unless options[:metadata].nil?
    Event.create(attributes)
  end
end
