# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Recipe, user_id: user.id
    can :manage, Food, user_id: user.id
    can :read, :all
  end
end
