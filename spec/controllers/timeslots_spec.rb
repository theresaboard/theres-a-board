require 'rails_helper'
describe TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:timeslot) { FactoryGirl.build(:timeslot).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
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
