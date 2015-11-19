json.array! @availabilities do |entry|
    json.id entry.mentor.id
    json.name entry.mentor.name
    json.image entry.mentor.image
end
