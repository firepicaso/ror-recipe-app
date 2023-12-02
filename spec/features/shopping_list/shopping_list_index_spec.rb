require 'rails_helper'

RSpec.describe 'shopping_lists/index', type: :view do
  before(:each) do
    assign(:ingredients,
           { 'Apple' => [double('Ingredient',
                                food: double('Food', name: 'Apple', measurement_unit: 'kg', price: 3))] })
    assign(:missing_numbers, { 'Apple' => 2 })
    assign(:total_price, 6)

    render
  end

  it 'renders the shopping list heading' do
    expect(rendered).to have_selector('h1', text: 'Shopping List')
  end

  it 'renders the amount of food items to buy' do
    expect(rendered).to have_content('Amount of Food items to buy: 1')
  end

  it 'renders the total value of food needed' do
    expect(rendered).to have_content('Total value of Food needed: $6.00')
  end

  it 'renders the table headers' do
    expect(rendered).to have_selector('thead th', text: 'Name')
    expect(rendered).to have_selector('thead th', text: 'Quantity')
    expect(rendered).to have_selector('thead th', text: 'Price')
  end

  it 'renders the food name in the table' do
    expect(rendered).to have_selector('tbody td', text: 'Apple')
  end

  it 'renders the quantity and measurement unit in the table' do
    expect(rendered).to have_selector('tbody td', text: '2 kg')
  end

  it 'renders the total price in the table' do
    expect(rendered).to have_selector('tbody td', text: '$6.00')
  end
end
