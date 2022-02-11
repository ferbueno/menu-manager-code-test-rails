class Dish < ApplicationRecord
  has_one :menu_dish, dependent: :delete
  has_one :menu, through: :menu_dish

  before_validation :dish_name_hash_generate

  validates :name, presence: true, length: { minimum: 1 }
  validates :price, presence: true, numericality: true
  validates :name_hash, uniqueness: true

  validate :name_must_not_start_with_e

  def name_must_not_start_with_e
    if name && !name.empty?
      errors.add :name, "Dish must not start with letter 'E'" if name[0].downcase == 'e'
    end
  end

  def dish_name_hash_generate
    return unless name

    self.name_hash = Digest::SHA256.hexdigest name.downcase.gsub(/\s+/, '')
  end
end
