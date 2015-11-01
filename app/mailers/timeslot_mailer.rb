class TimeslotMailer < ApplicationMailer

  def tutor_scheduled(timeslot)
    @timeslot = timeslot
    mail to: @timeslot.tutor.email, subject: "Mentor Me Scheduling Notification"
  end

  def student_scheduled(timeslot)
    @timeslot = timeslot
    mail to: @timeslot.student.email, subject: "Mentor Me Scheduling Notification"
  end
end
