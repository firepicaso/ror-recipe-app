class InventoryFood < ApplicationRecord
  belongs_to :food
  belongs_to :inventory

  validates :quantity, presence: true
end
