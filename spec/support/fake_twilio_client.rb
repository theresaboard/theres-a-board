class FakeTwilioClient
  Message = Struct.new(:from, :to, :body)

  cattr_accessor :messages
  self.messages = []

  def initialize
  end

  def messages
    self
  end

  def create(from:, to:, body:)
    self.class.messages << Message.new(from: from, to: to, body: body)
  end
end
