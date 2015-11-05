class Share < ActiveRecord::Base
  include PgSearch

  multisearchable :against => [:title, :description]
  pg_search_scope :search, :against => {title: 'A', description: 'B'},
                  :using => {
                    :tsearch => {:dictionary => "english"}
                  }

  belongs_to :user

  validates_presence_of :url, :title, :user
  validate :http_pad, :host_empty

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

  private
  def http_pad
    parsed_url = URI.parse(self.url)
    self.url = "http://#{url}" if parsed_url.scheme.nil?
  end

  def host_empty
    parsed_url = URI.parse(url)
    errors.add("Url can't be blank.") if parsed_url.host.nil?
  end
end
