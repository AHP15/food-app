class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :cooking_time, numericality: { only_integer: true, greater_than_or_equl_to: 0 }
  validates :preparation_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user, class_name: 'User'

  has_many :recipe_food, class_name: 'RecipeFood'

  def food_items_and_total_amount(id)
    total_amount = 0
    items = RecipeFood.where(recipe: id)

    items.each do |item|
      total_amount += item.food.price * item.quantity
    end

    { total_amount:, items: items.length }
  end
end
