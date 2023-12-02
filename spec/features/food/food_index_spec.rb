require 'rails_helper'

RSpec.feature 'Food List', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'dev', email: 'dev@example.com', password: 'password')
    @user.confirm
    log_in_user('dev@example.com', 'password')
  end

  scenario 'User views the Food List' do
    Food.create(name: 'Apple', measurement_unit: 'kg', price: '12', quantity: '1', user: @user)
    visit foods_path
    expect(page).to have_selector('tbody tr td', text: 'Apple')
    expect(page).to have_selector('tbody tr td', text: 'kg')
    expect(page).to have_selector('tbody tr td', text: '12')
    expect(page).to have_button('Delete')
  end

  scenario 'User can delete a food record' do
    Food.create(name: 'Apple', measurement_unit: 'kg', price: '12', quantity: '1', user: @user)
    visit foods_path
    expect(page).to have_button('Delete', count: 1)
    click_button 'Delete'
    sleep(1)
    expect(Food.count).to eq(0)
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
