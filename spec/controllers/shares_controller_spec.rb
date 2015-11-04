require 'rails_helper'

describe SharesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:share_attribs) { FactoryGirl.attributes_for(:share) }
  let(:share_fail_attribs) { FactoryGirl.attributes_for(:share_invalid) }

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
end
