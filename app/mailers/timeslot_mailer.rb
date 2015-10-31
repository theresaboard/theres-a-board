class TimeslotMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.timeslot_mailer.tutor_scheduled.subject
  #
  def tutor_scheduled
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.timeslot_mailer.student_scheduled.subject
  #
  def student_scheduled
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
