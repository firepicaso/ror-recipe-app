require 'rails_helper'

RSpec.feature 'Add Food Details', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'dan', email: 'dan@example.com', password: 'password')
    @user.confirm
    log_in_user('dan@example.com', 'password')
    visit new_food_path
  end

  scenario 'User adds food' do
    fill_in 'Name', with: 'Apple'
    fill_in 'food_measurement_unit', with: 'kg'
    fill_in 'Price', with: 10
    fill_in 'Quantity', with: 1
    click_button 'Create Food'
    created_food = Food.last
    expect(created_food.name).to eq('Apple')
    expect(created_food.measurement_unit).to eq('kg')
    expect(created_food.price).to eq(10)
  end

  scenario 'User submits the new food creation form with invalid data' do
    existing_food_count = Food.count
    click_button 'Create Food'
    expect(Food.count).to eq(existing_food_count)
  end

  private

  def log_in_user(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
    sleep(1)
  end
end