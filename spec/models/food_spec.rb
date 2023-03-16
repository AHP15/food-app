require 'rails_helper'

RSpec.describe Food, type: :model do
  subject do
    Food.new(name: 'apple', measurement_unit: 'kg', price: 5, quantity: 10, user_id: 1)
  end
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'measurement_unit should be present' do
    subject.measurement_unit = nil
    expect(subject).to_not be_valid
  end

  it 'price should be present' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'quantity should be present' do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it 'user id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end
