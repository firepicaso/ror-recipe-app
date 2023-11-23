class InventoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_inventory, only: [:show, :destroy]
  
    def index
      @inventories = current_user.inventories
    end
  
    def show
      @inventory_foods = @inventory.inventory_foods.includes(:food)
    rescue ActiveRecord::RecordNotFound
      flash_and_redirect("Inventory not found", inventories_path)
    end
  
    def destroy
      @inventory.destroy
      flash_and_redirect("Inventory was successfully removed", inventories_path)
    rescue ActiveRecord::RecordNotFound
      flash_and_redirect("Inventory not found", inventories_path)
    end
  
    def new
      @new_inventory = Inventory.new
    end
  
    def create
      inventory = Inventory.new(user: current_user, name: inventory_params[:name])
  
      respond_to do |format|
        if inventory.save
          flash_and_redirect("Created an inventory successfully", inventories_path, format)
        else
          flash_and_redirect("Failed to create an inventory. Try again", new_inventory_path, format)
        end
      end
    rescue StandardError => e
      flash_and_redirect(e.message, inventories_path)
    end
  
    private
  
    def set_inventory
      @inventory = current_user.inventories.find(params[:id])
    end
  
    def inventory_params
      params.require(:inventory).permit(:name)
    end
  
    def flash_and_redirect(message, path, flash_type = :notice, format = nil)
        flash[flash_type] = message
        format.html { redirect_to path } if format
        redirect_to path
    end
  end
