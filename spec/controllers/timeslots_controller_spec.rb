require 'rails_helper'
describe TimeslotsController do
  let(:user) { FactoryGirl.create(:user) }
  let!(:timeslot) { FactoryGirl.build(:timeslot) }

  context "#show" do
    it "should render student dialog for student user" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      timeslot.student_id = user.id
      timeslot.save
      get :show, id: timeslot.id
      expect(response).to render_template('timeslots/student_appt_show')
    end
    it "should render tutor dialog for tutor user" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      timeslot.tutor_id = user.id
      timeslot.save
      get :show, id: timeslot.id
      expect(response).to render_template('timeslots/tutor_appt_show')
    end
    it "should render available dialog for unaffiliated user" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      timeslot.save
      get :show, id: timeslot.id
      expect(response).to render_template('timeslots/appt_show')
    end
  end

  context "SecuredController#logged_in_using_omniauth?" do
    let(:timeslot) { FactoryGirl.create(:timeslot) }
    it "should redirect if not logged in" do
      session.clear
      get :show, id: timeslot.id
      expect(response).to redirect_to login_path
    end
  end

end
