# Preview all emails at http://localhost:3000/rails/mailers/timeslot_mailer
class TimeslotMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/timeslot_mailer/tutor_scheduled
  def tutor_scheduled
    timeslot = Timeslot.where.not(student_id: nil).first
    TimeslotMailer.tutor_scheduled(timeslot)
  end

  # Preview this email at http://localhost:3000/rails/mailers/timeslot_mailer/student_scheduled
  def student_scheduled
    timeslot = Timeslot.where.not(student_id: nil).first
    TimeslotMailer.student_scheduled(timeslot)
  end

end
