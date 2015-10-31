json.array! @timeslots do |slot|
    json.id slot.id
    json.title slot.tutor.name
    json.start slot.start
    json.end slot.end
end