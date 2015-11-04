class TextMessage

  def self.client
    @client ||= Twilio::REST::Client.new
  end

  def self.send(recipient, message)
      self.client.messages.create(
        from: '+16464553001', # Twilio account phone number
        to:   "+1#{recipient.cellphone}",
        body: message
      )
end
