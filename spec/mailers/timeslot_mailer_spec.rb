require "rails_helper"

RSpec.describe TimeslotMailer, type: :mailer do
  describe "tutor_scheduled" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_scheduled(timeslot) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mentor Me Scheduling Notification")
      expect(mail.to).to eq(["mentor.me.dev@gmail.com"])
      expect(mail.from).to eq(["mentor.me.dev@gmail.com"])
    end

  end

  describe "student_scheduled" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_scheduled(timeslot) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mentor Me Scheduling Notification")
      expect(mail.to).to eq(["mentor.me.dev@gmail.com"])
      expect(mail.from).to eq(["mentor.me.dev@gmail.com"])
    end

  end

  describe "tutor_cancel" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_cancel(timeslot, timeslot.student) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mentor Me Cancellation Notification")
      expect(mail.to).to eq(["mentor.me.dev@gmail.com"])
      expect(mail.from).to eq(["mentor.me.dev@gmail.com"])
    end

  end

  describe "student_cancel" do
    let!(:timeslot) { FactoryGirl.create(:booked_timeslot)}
    let!(:mail) { TimeslotMailer.tutor_cancel(timeslot, timeslot.student) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mentor Me Cancellation Notification")
      expect(mail.to).to eq(["mentor.me.dev@gmail.com"])
      expect(mail.from).to eq(["mentor.me.dev@gmail.com"])
    end

  end

end
