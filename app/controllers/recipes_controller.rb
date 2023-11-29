class RecipesController < ApplicationController
  load_and_authorize_resource

  before_action :set_recipe, only: [:show, :destroy, :update]

  def index
    @recipes = current_user.recipes.order(id: :asc)
  end

  def show
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    save_recipe('created successfully!', 'Error: recipe could not be created!', :new)
  end

  def destroy
    @recipe.destroy!
    flash[:success] = 'Recipe was deleted successfully!'
    redirect_to recipes_url
  end

  def update
    toggle_recipe_status
    redirect_to recipe_path
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(id: :desc)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def save_recipe(success_msg, error_msg, render_page)
    if @recipe.save
      flash[:success] = success_msg
      redirect_to recipes_url
    else
      flash.now[:error] = error_msg
      render render_page, locals: { recipe: @recipe }
    end
  end

  def toggle_recipe_status
    if @recipe.public
      @recipe.update!(public: false)
      flash[:notice] = 'Recipe status changed to private'
    else
      @recipe.update!(public: true)
      flash[:notice] = 'Recipe status changed to public'
    end
  end
end
