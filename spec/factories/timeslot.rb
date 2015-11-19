FactoryGirl.define do
  factory(:timeslot) do
    tutor
    start {
      date = Faker::Date.forward(7) + 10
      hour = rand(24)
      half_hour = rand(2) == 1 ? 0 : 30
      datetime = Time.local(date.year, date.month, date.day, hour, half_hour).to_s
    }

    factory(:booked_timeslot) do
      student
    end
    factory(:another_booked_timeslot) do
      student
    end
    factory(:empty_timeslot) do
      student nil
    end
  end

end
