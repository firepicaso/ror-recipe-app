require 'rails_helper'

RSpec.describe 'Food index page', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Albert Antwi', email: 'albertkantwi@gmail.com', password: '123456')
    
    visit '/users/sign_in'
    fill_in 'Email', with: 'albertkantwi@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    # Create some sample foods for the user
    @food1 = @user1.foods.create(food: 'Apple', measurement_unit: 'kg', price: 15)
    @food2 = @user1.foods.create(food: 'Banana', measurement_unit: 'each', price: 10)

    visit '/foods'
  end

  it 'should have the greetings' do
    expect(page).to have_content('Food List')
    expect(page).to have_link('Foods')
    expect(page).to have_link('Recipes')
    expect(page).to have_content('Add Food')
  end

  it 'should have the Add food link' do
    click_link 'Add Food'
    expect(current_path).to eq(new_food_path)
  end

  it 'should display existing foods' do
    expect(page).to have_content('Apple')
    expect(page).to have_content('Banana')
  end

  it 'should display delete link for user\'s foods' do
    expect(page).to have_content('Delete', count: 2) # Assuming two foods are created in the before block
  end

  it 'should delete a food', js: true do
    accept_confirm do
      first(:link, 'Delete').click
    end
    expect(page).not_to have_content('Apple')
  end
end