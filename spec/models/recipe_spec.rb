require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    Recipe.new(
      name: 'Recipe 1',
      preparation_time: '1',
      cooking_time: '1.5',
      description: 'recipe description...',
      user_id: 1
    )
  end

  before { subject.save }

  it 'name should be prevsent' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'preparation_time should be prevsent' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'cooking_time should be prevsent' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'description should be prevsent' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  describe 'Should validate Recipe model fields' do
    let(:user) { User.create(email: 'eamils@me.com', password: 'passcode123') }
    subject do
      described_class.new(name: 'Recipe 1', preparation_time: '1', cooking_time: '1.5',
                          description: 'recipe description...', user:)
    end
    it { should belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:preparation_time) }
    it { is_expected.to validate_numericality_of(:cooking_time) }
    it { is_expected.to validate_presence_of(:public) }
  end
end
