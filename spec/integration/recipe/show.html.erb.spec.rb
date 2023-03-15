require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  scenario 'User interaction with the recipe detail page' do
    user = User.last
    visit "/users/#{user.id}/recipes"
    expect(page).to have_current_path('/users/sign_in')
  end
end