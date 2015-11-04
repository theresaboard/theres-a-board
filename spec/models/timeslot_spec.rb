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

    it "should not let a tutor claim his or her own timeslot" do
      timeslot = FactoryGirl.create(:timeslot)
      expect {
        timeslot.student_id = timeslot.tutor_id
        timeslot.save
        expect(timeslot.errors.full_messages).to include("Student you can't tutor yourself :/")
      }.not_to change { timeslot.reload.student_id }
    end

    it "should require start to be in the future" do
      timeslot = FactoryGirl.build(:timeslot)
      expect {
        timeslot['start'] = Time.zone.now
        timeslot.save
        expect(timeslot.errors.full_messages).to include("Start must be in the future")
      }.not_to change { Timeslot.count }
    end

  end

  context "associations" do
    it { is_expected.to belong_to :tutor}
    it { is_expected.to belong_to :student}
  end

  context "#end" do
    it "should return start plus 30 minutes" do
      timeslot = FactoryGirl.create(:timeslot)
      expect(timeslot.end).to eq(timeslot.start + 30.minutes)
    end
  end

  context "#open?" do
    it "should return true for booked session" do
      timeslot = FactoryGirl.create(:booked_timeslot)
      expect(timeslot.open?).to be_falsy
    end
    it "should return false for unclaimed session" do
      timeslot = FactoryGirl.create(:timeslot)
      expect(timeslot.open?).to be_truthy
    end
  end

end
