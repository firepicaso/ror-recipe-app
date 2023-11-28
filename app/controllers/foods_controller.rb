class FoodsController < ApplicationController
    before_action :set_food, only: [:show, :edit, :destroy]
  
    # GET /foods
    def index
      @foods = Food.all
    end
  
    # GET /foods/1
    def show
    end
  
    # GET /foods/new
    def new
      @food = Food.new
    end
  
    # POST /foods
    def create
      @food = Food.new(food_params)
  
      if @food.save
        redirect_to @food, notice: 'Food was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def destroy
      @food.destroy
      redirect_to foods_url, notice: 'Food was successfully destroyed.'
    end
  
    private
  
    def set_food
      @food = Food.find(params[:id])
    end
  
    def food_params
      params.require(:food).permit(:name, :measurement_unit, :price, :user_id)
    end
  end
  