json.array! @timeslots do |slot|
    json.title slot.tutor.name
    json.start slot.start
    json.end slot.end
end