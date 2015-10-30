require 'rails_helper'
describe Api::TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:timeslot) { FactoryGirl.build(:timeslot).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do
    it "should be able to create a new timeslot" do
      expect do
        post :'create', { timeslots: [timeslot] }
      end.to change{Timeslot.count}.by(1)
    end
  end

end
