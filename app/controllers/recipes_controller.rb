class RecipesController < ApplicationController
  layout 'application'
  def public_index
    @recipes = Recipe.where(public: true).order(created_at: :desc).limit(3)
    @recipes = @recipes.map do |recipe|
      data = recipe.food_items_and_total_amount(recipe.id)
      { recipe:, recipe_data: data }
    end

    render 'public_index'
  end
end
