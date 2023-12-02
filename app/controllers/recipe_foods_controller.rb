class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    if @recipe_food.save
      flash[:success] = 'Ingredient added successfully!'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash.now[:error] = 'Error: ingredient could not be added!'
      render :new, locals: { recipe_food: @recipe_food }
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy!
    flash[:success] = 'Ingredient was deleted successfully!'
    redirect_to recipe_path(@recipe_food.recipe_id)
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Ingredient updated successfully!'
      redirect_to recipe_path(params[:recipe_id])
    else
      flash.now[:error] = 'Error: ingredient could not be updated!'
      render :edit, locals: { recipe_food: @recipe_food }
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
