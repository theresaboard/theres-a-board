require 'rails_helper'
describe Api::MentorRequestsController do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#open' do
    it 'should exist' do
      post :open
      expect(response).to be_success
    end

    it 'should be able to create a new request' do
      expect do
        post :open
      end.to change{MentorRequest.count}.by(1)
    end

  end

  describe '#status' do
    it 'should exist' do
      get :status
      expect(response).to be_success
    end

    it 'return 0 with no open requests' do
      get :status
      expect(response.body).to include("{\"open\":0}")
    end

    it 'shoud not return 0 with open respones' do
      post :open
      get :status
      expect(response.body).to_not include("{\"open\":0}")
    end

    it 'return 1 with open respones' do
      post :open
      get :status
      expect(response.body).to include("{\"open\":1}")
    end

  end

  describe '#close' do
    let(:mentor_request) { FactoryGirl.create(:mentor_request) }

    it 'should be able to close an open request' do
      post :open
      expect do
        put :close
      end.to change{MentorRequest.open_by_user(user).size}.by(-1)
    end
  end
 

end
