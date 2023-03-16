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
    # @user_id = current_user.id
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
    @recipe = Recipe.where(user: current_user.id)
  end

  def destroy; end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end
