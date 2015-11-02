require 'rails_helper'

describe Timeslot do

  context "validations" do

    it { is_expected.to validate_presence_of :start }
    it { is_expected.to validate_presence_of :tutor_id }
    subject { FactoryGirl.create(:timeslot) }
    it {
      is_expected.to validate_uniqueness_of(:tutor_id)
        .scoped_to(:start)
        .with_message('you are already available at this time')
    }
    subject { FactoryGirl.create(:booked_timeslot) }
    it {
      is_expected.to validate_uniqueness_of(:student_id)
        .scoped_to(:start)
        .with_message('you are already scheduled for another session at this time')
    }
  end

  context "associations" do
    it { is_expected.to belong_to :tutor}
    it { is_expected.to belong_to :student}
  end
end
