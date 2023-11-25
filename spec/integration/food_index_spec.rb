require 'rails_helper'

RSpec.describe 'Food index page', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Albert Antwi', email: 'albertkantwi@gmail.com', password: '123456')
    
    visit '/users/sign_in'
    fill_in 'Email', with: 'albertkantwi@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    visit '/foods'
  end

  it 'should have the following content' do
    expect(page).to have_content('Hi Albert Antwi')
    expect(page).to have_content('Food List')
    expect(page).to have_link('Foods')
    expect(page).to have_link('Recipes')
    expect(page).to have_content('Please add foods using the Add Food button')
  end

  it 'should have the following content' do
    click_link 'Add Food'
    expect(current_path).to eq(new_food_path)
  end
end