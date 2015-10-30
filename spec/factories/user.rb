FactoryGirl.define do
  factory(:user, aliases: [:tutor, :student]) do
    name { Faker::Name.name }
  end
end
