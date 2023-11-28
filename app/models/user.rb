class User < ApplicationRecord
  has_many :foods, dependent: :delete_all
  has_many :recipes, dependent: :delete_all

  validates :name, presence: true
end
