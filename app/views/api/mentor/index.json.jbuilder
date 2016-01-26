json.array! @requests do |req|
    json.id req.id
    json.username req.student.name
    json.open time_ago_in_words(req.created_at)
    json.image req.student.image
end
