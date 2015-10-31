# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_count = 25
user_count.times do
  User.create(name: Faker::Name.name, image: Faker::Avatar.image)
end

user_ids = User.ids

25.times do
  date = Faker::Date.forward(7)
  hour = rand(24)
  half_hour = rand(2) == 1 ? 0 : 30
  datetime = Time.local(date.year, date.month, date.day, hour, half_hour)
  tutor_id = user_ids.sample
  student_id = rand(2) == 1 ? (user_ids - [tutor_id]).sample : nil
  Timeslot.create(start: datetime, tutor_id: tutor_id, student_id: student_id)
end
