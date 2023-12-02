require 'rails_helper'

RSpec.describe 'When I open user index page', type: :feature do
  before(:each) do
    User.delete_all
    @user = User.create(name: 'dev', email: 'dev@example.com', password: 'password')
    @user.confirm
    sleep(1)

    visit new_user_session_path
    fill_in 'Email', with: 'dev@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    sleep(1)

    @recipe1 = Recipe.create(user: @user, name: 'Fried Rice', description: 'This is my favourite rice dish!',
                             preparation_time: 0, cooking_time: 0)
    @recipe2 = Recipe.create(user: @user, name: 'Chicken Fry', description: 'I love Chicken!',
                             preparation_time: 0, cooking_time: 0)
    visit(recipes_path)
    sleep(1)
  end

  it 'shows the correct My Recipe heading' do
    expect(page).to have_content('My Recipes')
  end

  it 'shows the names of all recipes' do
    expect(page).to have_content('Fried Rice')
    expect(page).to have_content('Chicken Fry')
  end

  it 'shows the REMOVE button 2 times' do
    expect(page).to have_button('REMOVE', count: 2)
  end

  it 'shows the Add Recipe button' do
    expect(page).to have_link('Add Recipe', href: new_recipe_path)
  end

  context 'When I click on a Recipe name' do
    it "redirects me to that recipe's show page" do
      click_link('Fried Rice')
      expect(page).to have_current_path(recipe_path(@recipe1))
    end

    it "redirects me to that recipe's show page" do
      click_link('Chicken Fry')
      expect(page).to have_current_path(recipe_path(@recipe2))
    end
  end

  context 'When I click on a Add Recipe button' do
    it 'redirects me to form that adds Recipe' do
      click_link('Add Recipe')
      expect(page).to have_current_path(new_recipe_path)
    end
  end

  context 'When I click on REMOVE button' do
    it 'removes this item' do
      within first('.card') do
        click_button('REMOVE')
        sleep(1)
      end
      expect(page).to_not have_content('Fried Rice')
    end
  end
end
