require 'rails_helper'

describe SharesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:share_attribs) { FactoryGirl.attributes_for(:share) }
  let(:share_fail_attribs) { FactoryGirl.attributes_for(:share_invalid) }
  let(:saved_share) { FactoryGirl.create(:share) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  context '#index' do
    it "should have an index route" do
      get :index
      expect(response).to be_success
    end
  end

  context '#new' do
    it "should have a route to new " do
      get :new
      expect(response).to render_template('shares/new')
    end
  end

  context '#create' do
    it "should create a share with proper data from user" do
      expect{ post :create, share: share_attribs }.to change{Share.count}.by(1)
    end

    it "should not create a share with bad data from user" do
      expect{ post :create, share: share_fail_attribs }.to change{Share.count}.by(0)
    end
  end

  context '#search' do
    it 'should return a share when searching existing records' do
      post :search, search: saved_share.title
      expect(response).to be_success
      expect(assigns(:shares).first).to eq(saved_share)
    end

    it 'should not return a share if nothing is found' do
      post :search, search: nil
      expect(assigns(:shares)).to be_empty
    end
  end
end
