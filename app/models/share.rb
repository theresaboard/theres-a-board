class Share < ActiveRecord::Base
  include PgSearch

  multisearchable :against => [:title, :description]
  pg_search_scope :search, :against => {title: 'A', description: 'B'},
                  :using => {
                    :tsearch => {:dictionary => "english"}
                  }

  belongs_to :user

  validates_presence_of :url, :title, :user
end
