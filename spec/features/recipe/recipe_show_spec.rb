require 'rails_helper'

RSpec.describe 'When I open user show page', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'dan', email: 'dan@example.com', password: 'password')
    @user.confirm
    sleep(1)

    visit new_user_session_path
    fill_in 'Email', with: 'dan@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    sleep(1)

    @recipe = Recipe.create(user: @user, name: 'Fried Rice', description: 'This is my favourite rice dish!',
                            preparation_time: 2, cooking_time: 1)
    visit(recipe_path(@recipe))
  end

  it 'shows the name of the recipe' do
    expect(page).to have_content('Fried Rice')
  end

  it 'shows the cooking time' do
    expect(page).to have_content('Cooking time: 1.0 hour')
  end

  it 'shows the preparation time' do
    expect(page).to have_content('Preparation time: 2.0 hours')
  end

  it 'shows the full description' do
    expect(page).to have_content('This is my favourite rice dish!')
  end

  it 'shows the Private button' do
    expect(page).to have_button('Private')
  end

  context 'shows correct links' do
    it 'Generates Shopping List' do
      expect(page).to have_link('Generate Shopping List', href: shopping_lists_path)
    end

    it 'Adds Ingredient' do
      expect(page).to have_link('Add Ingredient', href: new_recipe_recipe_food_path(@recipe))
    end
  end

  context 'When I click on Add Ingredient' do
    it 'redirects me to the form that adds new recipe_foods' do
      click_link('Add Ingredient')
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end
  end

  context 'When I click on Generate Shopping List' do
    it 'redirects me to the shopping list path' do
      click_link('Generate Shopping List')
      expect(page).to have_current_path(shopping_lists_path)
    end
  end

  context 'When I click on a Private button' do
    it 'toggles it and change the text to Prublic' do
      click_button('Private')
      expect(page).to have_button('Public')
      click_button('Public')
      expect(page).to have_button('Private')
    end
  end
end