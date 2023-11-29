class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: [:destroy]

  def index
    @foodlist = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food.destroy
    redirect_to foods_path, notice: 'Successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def set_food
    @food = current_user.foods.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to foods_path, alert: 'Food not found.'
  end
end
