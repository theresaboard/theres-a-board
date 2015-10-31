require "rails_helper"

RSpec.describe TimeslotMailer, type: :mailer do
  describe "tutor_scheduled" do
    let(:mail) { TimeslotMailer.tutor_scheduled }

    it "renders the headers" do
      expect(mail.subject).to eq("Tutor scheduled")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "student_scheduled" do
    let(:mail) { TimeslotMailer.student_scheduled }

    it "renders the headers" do
      expect(mail.subject).to eq("Student scheduled")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
