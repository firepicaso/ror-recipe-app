class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foodlist = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.user == current_user
      @food.destroy
      redirect_to foods_path, notice: 'Successfully deleted.'
    else
      redirect_to foods_path, alert: 'You are not authorized to delete this food.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
