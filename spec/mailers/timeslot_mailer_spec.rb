require "rails_helper"

RSpec.describe TimeslotMailer, type: :mailer do
  describe "tutor_scheduled" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_scheduled(timeslot) }

    it "renders the headers" do
      expect(mail.subject).to eq("there's a board Scheduling Notification")
      expect(mail.to).to eq(["notify@theresaboard.com"])
      expect(mail.from).to eq(["notify@theresaboard.com"])
    end

  end

  describe "student_scheduled" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_scheduled(timeslot) }

    it "renders the headers" do
      expect(mail.subject).to eq("there's a board Scheduling Notification")
      expect(mail.to).to eq(["notify@theresaboard.com"])
      expect(mail.from).to eq(["notify@theresaboard.com"])
    end

  end

  describe "tutor_cancel" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_cancel(timeslot, timeslot.student) }

    it "renders the headers" do
      expect(mail.subject).to eq("there's a board Cancellation Notification")
      expect(mail.to).to eq(["notify@theresaboard.com"])
      expect(mail.from).to eq(["notify@theresaboard.com"])
    end

  end

  describe "student_cancel" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_cancel(timeslot, timeslot.student) }

    it "renders the headers" do
      expect(mail.subject).to eq("there's a board Cancellation Notification")
      expect(mail.to).to eq(["notify@theresaboard.com"])
      expect(mail.from).to eq(["notify@theresaboard.com"])
    end

  end

end
