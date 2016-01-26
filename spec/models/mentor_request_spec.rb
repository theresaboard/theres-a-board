require 'rails_helper'

describe MentorRequest do

  context "validations" do

    it { is_expected.to validate_presence_of :student }

  end

  context "associations" do
    it { is_expected.to belong_to :student}
  end

  context "#close" do
    it "should close the request" do
      mentor_request = FactoryGirl.create(:mentor_request)
      expect{mentor_request.close}.to change{mentor_request.open}.from(true).to(false)
    end
  end

end
