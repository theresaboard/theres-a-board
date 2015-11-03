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

  def end
    start + 30.minutes
  end

  def open?
    student.nil?
  end

  def send_tutor_scheduling_email
    TimeslotMailer.tutor_scheduled(self).deliver_now unless self.tutor.email.nil?
  end

  def send_student_scheduling_email
    TimeslotMailer.student_scheduled(self).deliver_now unless self.student.email.nil?
  end

  def send_tutor_cancel_email(student)
    TimeslotMailer.tutor_cancel(self, student).deliver_now unless self.tutor.email.nil?
  end

  def send_student_cancel_email(student)
    TimeslotMailer.student_cancel(self, student).deliver_now unless student.email.nil?
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
