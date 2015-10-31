# Preview all emails at http://localhost:3000/rails/mailers/timeslot_mailer
class TimeslotMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/timeslot_mailer/tutor_scheduled
  def tutor_scheduled
    TimeslotMailer.tutor_scheduled
  end

  # Preview this email at http://localhost:3000/rails/mailers/timeslot_mailer/student_scheduled
  def student_scheduled
    TimeslotMailer.student_scheduled
  end

end
