FactoryGirl.define do
  factory(:timeslot) do
    tutor
    start {
      date = Faker::Date.forward(7) + 1
      hour = rand(24)
      half_hour = rand(2) == 1 ? 0 : 30
      datetime = Time.local(date.year, date.month, date.day, hour, half_hour)
    }

    factory(:booked_timeslot) do
      student
    end
  end
end
