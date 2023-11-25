require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password')
    food = Food.new(food: 'Apple', measurement_unit: 'kg', price: 12, user:)
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(measurement_unit: 'kg', price: 10)
    expect(food).not_to be_valid
  end

  it 'is not valid without a measurement unit' do
    food = Food.new(food: 'apple', price: 10)
    expect(food).not_to be_valid
  end

  it 'is not valid without a price' do
    food = Food.new(food: 'apple', measurement_unit: 'kg')
    expect(food).not_to be_valid
  end
end
