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

  def index
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end
    @recipes = Recipe.where(user: current_user.id)
    render 'index'
  end

  def new
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end
    @user_id = current_user.id
    render 'new'
  end

  def create
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end
    @recipe = current_user.recipe.build(recipe_params)
    if @recipe.save
      flash[:success] = 'Successfully created the recipe'
      redirect_to "/users/#{current_user.id}/recipes"
    else
      flash.now[:error] = 'Error: Recipe could not be saved'
      puts @recipe.errors.full_messages
      render 'new'
    end
  end

  def show
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.where(recipe: @recipe.id)
  end

  def in_user_food?(id, recipe_foods)
    recipe_foods.each do |re_food|
      return true if re_food.id == id
    end

    false
  end

  def shopping
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end

    recipe_foods = RecipeFood.where(recipe: params[:id])
    @shopping_food = recipe_foods

    render 'shopping'
  end

  def ingredient
    @recipe_id = params[:id]
    @user_id = current_user.id
    render 'ingredient'
  end

  def create_ingredient
    name = params[:food]['name']
    measurement_unit = params[:food]['measurement_unit']
    price = params[:food]['price']
    quantity = params[:food]['quantity']
    food = Food.new(name:, measurement_unit:, price:, quantity:, user_id: current_user.id)
    food.save
    @recipe = Recipe.find(params[:id])

    @recipe_food = RecipeFood.new(quantity:, food_id: food.id, recipe_id: @recipe.id);
    @recipe_food.save

    redirect_to "/users/#{current_user.id}/recipes/#{params[:id]}"
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    redirect_to user_recipe_path(user_id: current_user.id, id: @recipe.id)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path(current_user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time)
  end
end
