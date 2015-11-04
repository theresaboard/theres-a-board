class Share < ActiveRecord::Base
  include PgSearch
  belongs_to :user

  validates_presence_of :url, :title, :user
end
