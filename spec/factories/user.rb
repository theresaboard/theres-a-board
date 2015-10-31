FactoryGirl.define do
  factory(:user, aliases: [:tutor, :student]) do
    name  { Faker::Name.name }
    email 'mentor.me.dev@gmail.com'
    uid   { SecureRandom.urlsafe_base64 }
    image { Faker::Avatar.image(nil, "100x100") }
  end
end
