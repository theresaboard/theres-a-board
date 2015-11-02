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
    let(:timeslot) { FactoryGirl.create(:timeslot) }
    it "should not let a tutor claim his or her own timeslot" do
      expect{
        timeslot.student_id = timeslot.tutor_id
        timeslot.save
        expect(timeslot.errors.full_messages).to include("Student you can't tutor yourself :/")
      }.not_to change { timeslot.reload.student_id }
    end

  end

  context "associations" do
    it { is_expected.to belong_to :tutor}
    it { is_expected.to belong_to :student}
  end
end
