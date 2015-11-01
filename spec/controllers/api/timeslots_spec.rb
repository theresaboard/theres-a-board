require 'rails_helper'
describe Api::TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:timeslot_attribs) { FactoryGirl.attributes_for(:timeslot) }
  let(:persisted_timeslot) { FactoryGirl.create(:timeslot) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do
    it 'should exist' do
      post :create, timeslot_attribs
    expect(response).to be_success
    end

    it 'should be able to create a new timeslot' do
      expect do
        post :create, timeslot_attribs
      end.to change{Timeslot.count}.by(1)
    end

    it 'should not be able to create a new timeslot with invalid data' do
      expect do
        post :create, {start: nil, location: nil}
      end.to change{Timeslot.count}.by(0)
    end
  end

  describe '#update' do
    let(:timeslot) { FactoryGirl.create(:timeslot) }

    it 'should update a timeslot with valid data' do
      expect {
        post :update, id: timeslot.id
      }.to change { timeslot.reload.student_id }.to(user.id)
      expect(response).to be_success
    end
  end

  describe '#cancel' do
    let(:timeslot) { FactoryGirl.create(:booked_timeslot) }

    it 'should allow the tutor to cancel a session' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(timeslot.tutor)
      expect {
        patch :cancel, id: timeslot.id
      }.to change { timeslot.reload.student_id }.to(nil)
      expect(response).to be_success
    end

    it 'should allow the student to cancel a session' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(timeslot.student)
      expect {
        patch :cancel, id: timeslot.id
      }.to change { timeslot.reload.student_id }.to(nil)
      expect(response).to be_success
    end

    it 'should not allow user that is not tutor or student to cancel a session' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect {
        patch :cancel, id: timeslot.id
      }.not_to change { timeslot.reload.student_id }
    end

  end

end
