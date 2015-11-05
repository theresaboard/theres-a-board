json.array! @users do |user|
    json.id user[0].id
    json.name user[0].name
    json.image user[0].image
    json.tutor_sessions user[1]
    json.rank user[2]
end
