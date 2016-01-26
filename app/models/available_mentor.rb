class AvailableMentor < ActiveRecord::Base
  belongs_to :mentor, class_name: 'User'

  def self.checkout(user)
    self.where(mentor: user).each{|record| record.delete}
  end

  def self.checked_in?(user)
    if self.find_by(mentor: user)
      return true
    else
      return false
    end
  end
end
