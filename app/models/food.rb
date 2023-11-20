class Food < ApplicationRecord
    has_many :inventory_foods
    has_many :recipe_foods

    validates :name, presence: true
    validates :measurement_unit, presence: true
    validates :price, presence: true
end
