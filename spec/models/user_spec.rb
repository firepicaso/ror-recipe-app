require 'rails_helper'

RSpec.describe User, type: :model do
  context '#create validates required fields' do
    it 'is valid with existing name, email and password' do
      expect(User.create(name: 'Dan', email: 'dan@example.com', password: 'password')).to be_valid
    end

    it 'is not valid with blank name' do
      expect(User.create(email: 'dan@example.com', password: 'password')).to_not be_valid
    end

    it 'is not valid with blank email' do
      expect(User.create(name: 'dan', password: 'password')).to_not be_valid
    end

    it 'is not valid with blank password' do
      expect(User.create(name: 'dan', email: 'dan@example.com')).to_not be_valid
    end
  end
end