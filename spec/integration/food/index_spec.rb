RSpec.describe 'Foods', type: :system do
  before :all do
    @food = Food.create(
      name: 'apple', measurement_unit: 'kg', price: 5, quantity: 10, user_id: 1
    )
    @food.save
  end

  it 'shows the right content for index' do
    visit '/users/1/foods'
    expect(page).to have_content('Log in')
  end

  it 'shows the right content for add food' do
    visit '/users/1/foods/new'
    expect(page).to have_content('Log in')
  end
end
