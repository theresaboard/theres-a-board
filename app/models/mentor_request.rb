class MentorRequest < ActiveRecord::Base
  belongs_to :student, class_name: "User"
  validates_presence_of :student

  after_create :light_up

  def light_up
    Light.on
  end
    

  def self.open_by_user(user)
    self.where(student: user, open: true)
  end

  def self.close_all_by_user(user)
    self.open_by_user(user).each{|req| req.close}
  end

  def self.open_requests?
    self.where(open: true).size > 0
  end

  def close 
    self.open = false
    self.save
    unless MentorRequest.open_requests?
      Light.off
    end
  end

end