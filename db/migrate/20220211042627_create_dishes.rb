class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price, precision: 20, scale: 4
      t.string :name_hash

      t.timestamps
    end

    add_index :dishes, :name_hash, unique: true
  end
end
