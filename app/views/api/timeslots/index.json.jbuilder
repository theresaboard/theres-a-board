json.array! @timeslots do |slot|
    json.id slot.id
    json.title slot.tutor.name
    json.start slot.start
    json.end slot.end
    if slot.student
      json.color slot.booked_slot
    else
      json.color slot.open_slot
    end
end