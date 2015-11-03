module ApplicationHelper
  def start_day_time(timeslot)
    Time.zone.at(timeslot.start).strftime("%A at %l:%M %p")
  end

  def start_long_ordinal(timeslot)
    Time.zone.at(timeslot.start).to_date.to_formatted_s(:long_ordinal)
  end
end
