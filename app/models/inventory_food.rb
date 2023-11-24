class InventoryFood < ApplicationRecord
  belongs_to :food, foreign_key: 'food_id'
  belongs_to :inventory, foreign_key: 'inventory_id'

  validates :quantity, presence: true
end
