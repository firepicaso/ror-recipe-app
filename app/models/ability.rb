class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new
    can :manage, :all if user.present?
    can :manage, Food, user: user if user.present?
    can :manage, Recipe, user: user if user.present?
    can :manage, Inventory, user: user if user.present?
    can :manage, InventoryFood, inventory: { user_id: user.id }
  end
end