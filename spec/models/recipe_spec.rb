require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Greek Salad', 'preparation_time' => 0, 'cooking_time' => 0 } }
  let(:no_name) { { 'user' => @user, 'preparation_time' => 0, 'cooking_time' => 0 } }
  let(:no_prep) { { 'user' => @user, 'name' => 'Greek Salad', 'cooking_time' => 0 } }
  let(:no_cook) { { 'user' => @user, 'name' => 'Greek Salad', 'preparation_time' => 0, 'cooking_time' => 0 } }

  before :all do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
  end

  context '#create validates required fields' do
    it 'is valid with existing name' do
      expect(Recipe.new(valid_attributes)).to be_valid
    end

    it 'is not valid with blank name' do
      expect(Recipe.new(no_name)).to_not be_valid
    end
  end

  context '#create validates prep time and cooking time presence' do
    it 'is not valid without a paration_time' do
      expect(Recipe.new(no_prep)).to_not be_valid
    end

    it 'is valid without a cooking_time' do
      expect(Recipe.new(no_cook)).to be_valid
    end
  end
end