class CreateMenuDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_dishes do |t|
      t.references :menu, foreign_key: true
      t.references :dish, foreign_key: true

      t.timestamps
    end

    add_index :menu_dishes, %i[menu_id dish_id], unique: true
  end
end
