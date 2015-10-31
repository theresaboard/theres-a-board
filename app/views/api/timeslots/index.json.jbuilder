json.array! @timeslots do |slot|
    json.tutor slot.tutor
    json.student slot.student
    json.start slot.start
    json.created_at slot.created_at
    json.updated_at slot.updated_at
end