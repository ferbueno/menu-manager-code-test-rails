require 'rails_helper'

RSpec.describe MenuDish, type: :model do
  describe 'associations' do
    it { should belong_to(:dish).without_validating_presence }
    it { should belong_to(:menu).without_validating_presence }
  end

  describe 'validations' do
    before do
      @menu = Menu.create!(name: 'Starters')
      @first_dish = Dish.create!(name: 'Salsa', price: 44)
      @second_dish = Dish.create!(name: 'Tortillas', price: 33)
      MenuDish.create!(menu: @menu, dish: @first_dish)
    end

    context 'on creation' do
      it 'prices must not sum 77' do
        expect do
          MenuDish.create!(menu: @menu, dish: @second_dish)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'on update' do
      before do
        @second_menu = Menu.create!(name: 'Entrees')
        @third_dish = Dish.create!(name: 'Nachos', price: 33)
        @menu_dish = MenuDish.create!(menu: @second_menu, dish: @third_dish)
      end

      it 'prices must not sum 77' do
        expect do
          @menu_dish.update!(menu: @menu)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
