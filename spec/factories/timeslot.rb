FactoryGirl.define do
  factory(:timeslot) do
    start DateTime.now
  end
  factory(:persisted_timeslot) do
    start DateTime.now
    # tutor_id (rand(200)+100)
  end
end
