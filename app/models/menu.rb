class Menu < ApplicationRecord
  # Delete dependent, relations mean nothing if the menu does not exist
  # Instead of using soft delete
  has_many :menu_dishes, dependent: :delete_all
  has_many :dishes, through: :menu_dishes

  validates :name, presence: true
end
