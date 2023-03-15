require 'rails_helper'

# RSpec.describe 'Authentication', type: :request do
#   describe 'POST /auth/sign_in (Sign In process)' do
#     it 'Should respond with status 200(OK)' do
#       user = User.last
#       get "/users/confirmation?config=default&confirmation_token=#{user.confirmation_token}&redirect_url=/"
#       #Sign In
#       post '/users/sign_in', params: { user: { email: user.email, password: 'qwertyuiop' } }
#       puts user.confirmation_token
#       puts user.email
#       puts user.id
#       puts user.password

#       expect(response).to have_http_status(:success)
#     end
#   end
# end

RSpec.describe 'Recipe', type: :request do
  describe 'User creates a new recipe after logging in' do
    it 'Users sign in' do
      visit '/users/2/recipes/new'
      expect(page).to have_current_path('/users/sign_in')
      user = User.last
      get "/users/confirmation?config=default&confirmation_token=#{user.confirmation_token}&redirect_url=/"
      post '/users/sign_in', params: { user: { email: user.email, password: 'qwertyuiop' } }

      expect(page).to have_current_path("/users/#{user.id}/recipes/new")
      fill_in 'Name', with: 'Rice'
    end
  end
end
