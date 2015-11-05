class Share < ActiveRecord::Base
  include PgSearch

  multisearchable :against => [:title, :description]
  pg_search_scope :search, :against => {title: 'A', description: 'B'},
                  :using => {
                    :tsearch => {:dictionary => "english"}
                  }

  belongs_to :user

  validates_presence_of :url, :title, :user

  def color
    color_category = self.category
    case color_category
    when "Article"
      "success"
    when "Video"
      "info"
    when "Podcast"
      "orange"
    else
      "primary"
    end
  end
end
