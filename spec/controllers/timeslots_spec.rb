require 'rails_helper'
describe TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:timeslot) { FactoryGirl.attributes_for(:timeslot) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

end
