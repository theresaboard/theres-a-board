class Timeslot < ActiveRecord::Base
  belongs_to :tutor, class_name: 'User'
  belongs_to :student, class_name: 'User'

  validates_presence_of :start, :tutor_id
  validate :start_must_be_future
  validates :tutor_id, uniqueness: {
    scope: :start,
    message: 'you are already available at this time'
  }
  validate :tutor_and_student_unique
  validates :student_id, uniqueness: {
      scope: :start,
      message: 'you are already scheduled for another session at this time'
    }, unless: 'student_id.nil?'

    scope :booked, -> { where.not(student_id: nil) }
    scope :recent, -> { where(start: (Time.zone.now.midnight - 45.days)..Time.zone.now.beginning_of_day) }

  def end
    start + 30.minutes
  end

  def open?
    student.nil?
  end

  def send_booking_notifications
    if self.tutor.email_notify && !self.tutor.email.nil?
      TimeslotMailer.tutor_scheduled(self).deliver_now
    end
    if self.student.email_notify && !self.student.email.nil?
      TimeslotMailer.student_scheduled(self).deliver_now
    end
    if self.tutor.text_notify && !self.tutor.cellphone.nil?
      message = "#{self.student.name} requests to be tutored on " +
        "#{Time.zone.at(self.start).to_formatted_s(:notify_short)}. " +
        "You can contact this student at #{self.student.email}. " +
        "theresaboard.com"
      TextMessage.send(self.tutor, message)
    end
    if self.student.text_notify && !self.student.cellphone.nil?
      message = "You requested to be tutored on " +
        "#{Time.zone.at(self.start).to_formatted_s(:notify_short)} " +
        "by #{self.tutor.name}. You can contact this tutor at " +
        "#{self.tutor.email}. theresaboard.com"
      TextMessage.send(self.student, message)
    end
  end

  def send_cancel_notifications(student)
    if self.tutor.email_notify && !self.tutor.email.nil?
      TimeslotMailer.tutor_cancel(self, student).deliver_now
    end
    if student.email_notify && !student.email.nil?
      TimeslotMailer.student_cancel(self, student).deliver_now
    end
    if self.tutor.text_notify && !self.tutor.cellphone.nil?
      message = "Your tutor session with #{student.name} " +
        "on #{Time.zone.at(self.start).to_formatted_s(:notify_short)} " +
        "has been canceled. theresaboard.com"
      TextMessage.send(self.tutor, message)
    end
    if student.text_notify && !student.cellphone.nil?
      message = "Your tutor session with #{self.tutor.name} " +
        "on #{Time.zone.at(self.start).to_formatted_s(:notify_short)} " +
        "has been canceled. theresaboard.com"
      TextMessage.send(student, message)
    end
  end

  private

  def start_must_be_future
    if start.nil? || start <= Time.zone.now
      errors.add(:start, "must be in the future")
    end
  end

  def tutor_and_student_unique
    errors.add(:student_id, "you can't tutor yourself :/") if tutor_id == student_id
  end
end
