require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  before do
    @user_id = 4
    visit "/users/#{@user_id}/recipes/new"
    puts page.html
    expect(page).to have_css("form")
    # fill_in 'Name', with: 'Rice'
    # fill_in 'Description', with: 'Rice'
    # fill_in 'Cooking time', with: 'Rice'
    # fill_in 'Preparation time', with: 'Rice'
    check 'Public'
    # click_button 'Add Recipe'
  end
  it "redirects to the user's recipe creation page" do
    expect(page).to have_current_path("/users/#{@user_id}/recipes/create")
  end
end
