require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
  include Capybara::DSL
  scenario 'Logged in user can create a new Recipe' do
    user = User.last
    visit "/users/#{user.id}/recipes/new"
    expect(page).to have_current_path('/users/sign_in')
    post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    get "/users/confirmation?config=default&confirmation_token=#{user.confirmation_token}&redirect_url=/"
    expect(page).to have_http_status(:success)
    # expect(page).to have_current_path("/users/#{user.id}/recipes/new")
  end
end



