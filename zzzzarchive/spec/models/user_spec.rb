require 'rails_helper'

describe User do

  context "validations" do
    it { is_expected.to validate_presence_of :name }
  end

  context "associations" do
    it { is_expected.to have_many :timeslots}
    it { is_expected.to have_many :bookings}
  end
end
