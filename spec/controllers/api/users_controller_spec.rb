require 'rails_helper'
describe Api::UsersController do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#update' do

    it 'should update a timeslot with valid data' do
      expect {
        patch :update, id: user.id, email_notify: false
      }.to change { user.reload.email_notify }.to(false)
      expect(response).to be_success
    end

    it 'should not update a timeslot with invalid data' do
      expect {
        patch :update, id: user.id, email_notify: nil
      }.not_to change { user.reload.email_notify }
      expect(response).not_to be_success
    end

    it 'should return error messages with invalid data' do
      patch :update, id: user.id, text_notify: nil, cellphone: nil
      expect(user.errors.messages).not_to be_empty
    end
  end

end
