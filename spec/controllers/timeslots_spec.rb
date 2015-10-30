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
      post :create, { timeslot: timeslot['start'] }
      expect(response).to be_success
    end

    it 'should be able to create a new timeslot' do
      expect do
        post :create, { timeslot: timeslot['start'] }
      end.to change{Timeslot.count}.by(1)
    end

    it 'should not be able to create a new timeslot with invalid data' do
      expect do
        post :create, { timeslot: nil }
      end.to change{Timeslot.count}.by(0)
    end
  end

  describe '#update' do
    let(:timeslot) { FactoryGirl.create(:timeslot) }

    it 'should update a timeslot with valid data' do
      expect {
        post :update, { id: timeslot.id }
      }.to change { timeslot.reload.student_id }.to(user.id)
      expect(response).to be_success
    end

  end

end
