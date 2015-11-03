class TimeslotMailer < ApplicationMailer
  def tutor_scheduled(timeslot)
    @timeslot = timeslot
    mail to: @timeslot.tutor.email, subject: "there's a board Scheduling Notification"
  end

  def student_scheduled(timeslot)
    @timeslot = timeslot
    mail to: @timeslot.student.email, subject: "there's a board Scheduling Notification"
  end

  def tutor_cancel(timeslot, student)
    @timeslot = timeslot
    @student = student
    mail to: @timeslot.tutor.email, subject: "there's a board Cancellation Notification"
  end

  def student_cancel(timeslot, student)
    @timeslot = timeslot
    @student = student
    mail to: @student.email, subject: "there's a board Cancellation Notification"
  end
end
