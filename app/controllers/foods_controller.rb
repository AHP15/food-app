class FoodsController < ApplicationController
  layout 'application'

  def index
    if current_user.nil?
      redirect_to '/users/sign_in'
      return
    end

    @user_id = current_user.id
    @foods = Food.where(user: @user_id)
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

    name = params[:food]['name']
    measurement_unit = params[:food]['measurement_unit']
    price = params[:food]['price']
    quantity = params[:food]['quantity']
    food = Food.new(name:, measurement_unit:, price:, quantity:, user_id: current_user.id)

    if food.save
      flash[:success] = 'Food added successfully'
      redirect_to "/users/#{current_user.id}/foods"
    else
      flash.now[:error] = 'Error: Food could not be saved'
      render 'new'
    end
  end

  def delete
    RecipeFood.where(food: params[:id]).each(&:destroy)
    Food.find(params[:id]).destroy

    @user_id = current_user.id
    @foods = Food.where(user: @user_id)
    redirect_to "/users/#{@user_id}/foods"
  end
end
