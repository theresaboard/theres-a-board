require 'rails_helper'

describe TextMessage do

  context "::client" do
    it "should return a twilio client object" do
      expect(TextMessage.client).to be_a(Twilio::REST::Client)
    end
  end
end
