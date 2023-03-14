require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Should validate Recipe model fields' do
    it { is_expected.to validate_presence_of(:name).with_message("can't be blank") }
    it { should validate_presence_of(:description).with_message("can't be blank") }
    it { is_expected.to validate_numericality_of(:preparation_time).is_greater_than_or_equal_to(0).only_integer }
    it { is_expected.to validate_numericality_of(:cooking_time).only_integer }
    it { should belong_to(:user) }
  end
end