require 'rails_helper'
describe Api::TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user) }
  let(:timeslot_attribs) { FactoryGirl.attributes_for(:timeslot) }
  let!(:persisted_timeslot) { FactoryGirl.create(:timeslot) }
  let!(:empty_timeslot) { FactoryGirl.create(:empty_timeslot) }
  let(:another_booked_timeslot) { FactoryGirl.create(:another_booked_timeslot) }
  context "#index" do
    render_views

    it 'filters for ALL timeslots' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :index, format: :json, start: persisted_timeslot.start, end: persisted_timeslot.start, search: 'ALL'
      expect(assigns(:timeslots)).to eq([persisted_timeslot])
    end

    it 'filters for AVAILABLE timeslots' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get :index, format: :json, start: empty_timeslot.start, end: empty_timeslot.start, search: 'AVAILABLE'
      expect(response).to be_success
      expect(assigns(:timeslots)).to eq([empty_timeslot])
    end

    it 'filters for MINE timeslots' do
      tutor = another_booked_timeslot.tutor
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(tutor)
      get :index, format: :json, start: another_booked_timeslot.start, end: another_booked_timeslot.start, search: 'MINE'
      expect(response).to be_success
      expect(assigns(:timeslots)).to eq([another_booked_timeslot])
    end
  end

  describe '#create' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
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
        post :create, {start: nil}
      end.to change{Timeslot.count}.by(0)
    end
  end

  describe '#update' do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    let(:timeslot) { FactoryGirl.create(:timeslot) }

    it 'should update a timeslot with valid data' do
      expect {
        patch :update, id: timeslot.id
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

  context '#destroy' do
    let!(:timeslot) { FactoryGirl.create(:timeslot) }

    it 'should update a timeslot with valid data' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(timeslot.tutor)
      expect {
        delete :destroy, id: timeslot.id
      }.to change{Timeslot.count}.by(-1)
    end

    it 'should not update a timeslot with valid data' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect {
        delete :destroy, id: timeslot.id
      }.not_to change{Timeslot.count}
    end
  end
end
