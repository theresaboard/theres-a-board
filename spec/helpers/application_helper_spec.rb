require 'rails_helper'
describe ApplicationHelper do
  let!(:timeslot) { FactoryGirl.create(:timeslot) }

  context "#start_day_time" do
    it "should return a Timeslot#start formatted '%A at %l:%M %p'" do
      timeslot.start = "03 Nov 2015 03:30"
      expect(start_day_time(timeslot)).to eq("Tuesday at  3:30 AM")
    end
  end

end
