json.array! @timeslots do |slot|
    json.id slot.id
    json.title slot.tutor.name
    json.start slot.start
    json.end slot.end
    json.allDay false
    if slot.student
      json.color "#FF5722"
    else
      json.color "#2196F3"
    end
end