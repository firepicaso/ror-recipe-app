require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Fried Rice', 'preparation_time' => 1, 'cooking_time' => 1 } }
  let(:no_name) { { 'user' => @user, 'preparation_time' => 0, 'cooking_time' => 0 } }

  before :all do
    @user = User.create(name: 'dan', email: 'dan@example.com', password: 'password')
  end

  context '#create validates required fields' do
    it 'is valid with existing name' do
      expect(Recipe.new(valid_attributes)).to be_valid
    end

    it 'is not valid with blank name' do
      expect(Recipe.new(no_name)).to_not be_valid
    end
  end
end
