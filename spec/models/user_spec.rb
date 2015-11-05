require 'rails_helper'

describe User do

  context "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email_notify }
    it { is_expected.to validate_presence_of :text_notify }
  end

  context "when not requesting text notifications without a cellphone" do
    subject { User.new(text_notify: false) }
    it { is_expected.not_to validate_presence_of :cellphone }
  end

  context "when requesting text notifications without a cellphone" do
    subject { User.new(text_notify: true) }
    it {
      is_expected.to validate_presence_of(:cellphone)
      .with_message 'must be present for text notifications'
    }
  end

  context "associations" do
    it { is_expected.to have_many :timeslots}
    it { is_expected.to have_many :bookings}
  end
end
