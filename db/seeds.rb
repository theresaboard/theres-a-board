# Create users with unique UID (string), name (string, full name, and
# image (string, URI for avatar image).
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

# Create timeslots at random times (normalized to the nearest half hour) up to
# one week from Time.now.  Approximately 50% of timeslots are randomly booked by
# another student.
timeslots_count = 25
timeslots_count.times do
  date = Faker::Date.forward(7)
  hour = rand(24)
  half_hour = rand(2) == 1 ? 0 : 30
  datetime = Time.local(date.year, date.month, date.day, hour, half_hour)
  tutor_id, student_id = user_ids.sample(2)
  if rand(2) == 1
    student_id = nil
  else
    if rand(3) == 1
      subject = nil
    else
      subject = "How do you #{Faker::Hacker.verb} the #{Faker::Hacker.noun}?"
    end
  end
  Timeslot.create(start: datetime, tutor_id: tutor_id, student_id: student_id, subject: subject)
end
