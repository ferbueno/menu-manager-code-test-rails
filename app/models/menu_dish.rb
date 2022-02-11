class MenuDish < ApplicationRecord
  belongs_to :dish
  belongs_to :menu

  validate :dishes_must_not_sum_77

  def dishes_must_not_sum_77
    all_dishes = Dish.joins(:menu_dish).where(menu_dishes: { menu_id: menu_id })
    # Support creations and updates
    extra_price = 0
    extra_price = dish.price if new_record? || menu_id_changed?
    return unless all_dishes && all_dishes&.size.positive? && (all_dishes.sum(&:price) + extra_price) == 77.0

    errors.add(:base, 'Dishes must not sum 77')
  end
end
