# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create(name: Faker::Internet.user_name)
end

user_count = User.count

10.times do
  date = Date.today + rand(7) + 1
  time = Time.now + rand(86400)
  datetime = DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec, time.zone)
  user_id = rand(user_count) + 1
  Timeslot.create(start: datetime, tutor_id: user_id)
end
