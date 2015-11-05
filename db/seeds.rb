# Create users with unique UID (string), name (string, full name), and
# image (string, URI for avatar image).
# Approximately 50% of users have a cellphone and request text notifications.
# Email_notify is not provided, and defaults to true for all users.
user_count = 25
user_count.times do
  if rand(2) == 1
    text_notify = true
    cellphone = '5555555555'
  else
    text_notify = false
  end
  User.create(
    uid:         SecureRandom.urlsafe_base64,
    name:        Faker::Name.name,
    email:       'notify@theresaboard.com',
    image:       Faker::Avatar.image(nil, "100x100"),
    text_notify: text_notify,
    cellphone:   cellphone
  )
end

# Cache user ids for use in further seeds
user_ids = User.ids

# Create timeslots at random times (normalized to the nearest half hour) from
# 45 days in the past through one week from the present.
# Approximately 50% of timeslots are randomly booked by another student.
# Approximately 33% of timeslots have a subject.
# Validations are suppressed to allow for creation of old timeslots.
timeslots_count = 500
timeslots_count.times do
  date = Faker::Date.between(45.days.ago, Date.today + 7.days)
  hour = rand(24)
  half_hour = rand(2) == 1 ? 0 : 30
  datetime = Time.local(date.year, date.month, date.day, hour, half_hour)
  tutor_id, student_id = user_ids.sample(2)
  if rand(2) == 1
    student_id = nil
  end
  if rand(3) == 1
    subject = nil
  else
    subject = "How do you #{Faker::Hacker.verb} the #{Faker::Hacker.noun}?"
  end
  Timeslot.new(
    start: datetime,
    tutor_id: tutor_id,
    student_id: student_id,
    subject: subject
  ).save(validate: false)
end
