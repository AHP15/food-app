require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  let(:user) { User.create!(email: "user10@email.com", password: "passcode123")}
  before do
    login_as(user, scope: :user)
    user.confirmed_at = Time.now
    user.save
  end

  scenario 'Logged in user can create a new Recipe' do
    visit "users/#{user.id}/recipes/new"
    expect(page).to have_content('Create new recipe')
    fill_in 'Name', with: 'Ugali'
    fill_in 'Description', with: 'This is an African staple meal'
    fill_in 'Cooking time', with: 1
    fill_in 'Preparation time', with: 2
    check('Public')
    click_on 'Add Recipe'
    expect(page).to have_current_path("/users/#{user.id}/recipes")
  end
end