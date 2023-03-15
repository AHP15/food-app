class RecipesController < ApplicationController
  def index
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end
    @user_id = current_user.id
    @recipe = Recipe.where(user: @user_id)
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
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = 'Successfully created the recipe'
      redirect_to "/users/#{current_user.id}/recipes"
    else
      flash.now[:error] = 'Error: Recipe could not be saved'
      puts @recipe.errors.full_messages
      render 'new'
    end
  end

  def destroy
  end


  private
  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end