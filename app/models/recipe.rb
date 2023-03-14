class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :cooking_time, numericality: { only_integer: true, greater_than_or_equl_to: 0 }
  validates :preparation_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :user, class_name: 'User'
end