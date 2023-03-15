require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  before :all do
    @user = User.create(
      name: 'user 1',
      email: 'user@gmail.com',
      password: '1234',
      password_confirmation: '1234'
    )
    @recipe = Recipe.create(
      name: 'Recipe 1',
      preparation_time: '1',
      cooking_time: '1.5',
      description: 'recipe description...',
      user_id: @user.id
    )
  end

  it 'show the page title' do
    visit '/'
    expect(page).to have_content('Public Recipes')
  end

  it 'show the right path' do
    visit '/'
    expect(page).to have_current_path('/')
  end
end
