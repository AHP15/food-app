class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  has_many :recipe_foods, class_name: :recipe_foods
  has_many :foods, through: :recipe_foods
end
