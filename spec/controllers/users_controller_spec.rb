require 'rails_helper'
describe UsersController do

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#edit' do

    it 'should route to edit' do
     expect(:get => "users/#{user.id}/edit", id: user.id ).to route_to(
        :controller => "users",
        :action => "edit",
        :id => "#{user.id}"
        )
    end

    it 'should find the current user' do
      get 'edit', id: user.id
      expect(assigns(:user)).to eq user
    end

    it 'should render the edit form' do
      get 'edit', id: user.id
      expect(response).to render_template("edit")
    end
  end

end
