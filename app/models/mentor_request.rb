class MentorRequest < ActiveRecord::Base
  belongs_to :student, class_name: "User"

end