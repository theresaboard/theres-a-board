class Event 
  def self.client
    @client ||= Intercom::Client.new(app_id: IntercomRails.config.app_id, api_key: ENV["INTERCOM_API_KEY"])
  end

  def self.create(options)
    begin
      self.client.events.create(options)
    rescue
      return false
    end  
  end

end
