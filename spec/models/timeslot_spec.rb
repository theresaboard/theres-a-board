require 'rails_helper'

describe Timeslot do

  context "validations" do
    it { is_expected.to validate_presence_of :start }
    it { is_expected.to validate_presence_of :tutor_id }
  end

  context "associations" do
    it { is_expected.to belong_to :tutor}
    it { is_expected.to have_one :student}
  end
end
