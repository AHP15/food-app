require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  it 'recipe create page' do
    visit '/users/1/recipes/new'
    expect(page).to have_content('create new recipe')
  end
end
