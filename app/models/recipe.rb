class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_food, class_name: 'RecipeFood'

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  validates :public, presence: true

  def food_items_and_total_amount(id)
    total_amount = 0
    items = RecipeFood.where(recipe: id)

    items.each do |item|
      total_amount += item.food.price * item.quantity
    end

    { total_amount:, items: items.length }
  end
end
