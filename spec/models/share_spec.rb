require 'rails_helper'

describe Share do
  context 'validations' do
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :user }

    it { is_expected.to belong_to :user }
  end
end
