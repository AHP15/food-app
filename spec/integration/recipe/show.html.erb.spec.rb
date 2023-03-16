require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let!(:user) { User.create!(email: "testing@example.com", password: 'password')}
  let(:recipe) { 
    Recipe.create(
    name: 'Pasta Carbonara', user_id: user.id, public: true,
    cooking_time: 45, preparation_time: 50, description: 'This is a Spaniard dish'
  )}
  
  before do
    login_as(user, scope: :user)
    user.confirmed_at = Time.now
    user.save
  end

  scenario "Dispalying the Recipe detail page" do
    visit '/'
    expect(page).to have_content('My Recipes')
    click_on 'My Recipes'
    visit "/users/#{user.id}/recipes/#{recipe.id}/show"
    expect(page).to have_content(recipe.name)
    expect(page).to have_content("Preparation time #{recipe.preparation_time} hours")
    expect(page).to have_content("Cooking time #{recipe.cooking_time} hours")
    expect(page).to have_content(recipe.public ? 'Public' : 'Private')
  end

  scenario 'Toggle recipe from public to private' do
    visit '/'
    expect(page).to have_content('Public')

    click_button 'Make Private'
    expect(page).to have_content("Private")
    expect(recipe.reload.public).to eq(false)
  end

  scenario 'Toggle recipe from private to public' do
    recipe.update(public: false)
    visit '/'
    expect(page).to have_content("Private")
    
    click_button "Make Public"
    expect(page).to have_content("Public")
    expect(recipe.reload.public).to eq(true)
  end
end