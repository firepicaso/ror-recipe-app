class RecipeFoodsController < ApplicationController
    before_action :set_recipe_food, only: [:edit, :destroy, :update]
  
    def new
      @recipe_food = RecipeFood.new
    end
  
    def edit
    end
  
    def create
      @recipe_food = RecipeFood.new(recipe_food_params)
      @recipe_food.recipe_id = params[:recipe_id]
      handle_save('Ingredient added successfully!', 'Error: ingredient could not be added!', :new)
    end
  
    def destroy
      @recipe_food.destroy!
      flash[:success] = 'Ingredient was deleted successfully!'
      redirect_to recipe_path(@recipe_food.recipe_id)
    end
  
    def update
      handle_save('Ingredient updated successfully!', 'Error: ingredient could not be updated!', :edit)
    end
  
    private
  
    def set_recipe_food
      @recipe_food = RecipeFood.find(params[:id])
    end
  
    def handle_save(success_message, error_message, render_action)
      if @recipe_food.save
        flash[:success] = success_message
        redirect_to recipe_path(params[:recipe_id])
      else
        flash.now[:error] = error_message
        render render_action, locals: { recipe_food: @recipe_food }
      end
    end
  
    def recipe_food_params
      params.require(:recipe_food).permit(:quantity, :food_id)
    end
  end
  