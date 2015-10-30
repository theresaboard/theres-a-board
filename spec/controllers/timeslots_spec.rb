require 'rails_helper'
describe Api::TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:timeslot) { FactoryGirl.build(:timeslot).attributes }
  let(:persisted_timeslot) { FactoryGirl.create(:timeslot) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do
    it 'should exist' do
      post :create, { timeslots: [timeslot] }
      expect(response).to be_success
    end

    it 'should be able to create a new timeslot' do
      expect do
        post :create, { timeslots: [timeslot] }
      end.to change{Timeslot.count}.by(1)
    end

    it 'should not be able to create a new timeslot with invalid data' do
      expect do
        post :create, { timeslots: [] }
      end.to change{Timeslot.count}.by(0)
    end
  end
  describe '#update' do
    xit 'should exist' do
      post :update, { timeslot: persisted_timeslot, start: DateTime.now }
      expect(response).to be_success
    end

    xit 'should be able to update an existing timeslot' do
      time_now = DateTime.now + 10
      expect do
        post :update, { timeslot: persisted_timeslot, start: time_now }
      end.to change{persisted_timeslot.start}.from(persisted_timeslot.start).to(time_now)
    end

    xit 'should not be able to update an existing timeslot with invalid data' do
      time_now = nil
      expect do
        post :update, { timeslot: persisted_timeslot, start: time_now }
      end.to_not change{persisted_timeslot.start}.from(persisted_timeslot.start).to(time_now)
    end
  end

end
