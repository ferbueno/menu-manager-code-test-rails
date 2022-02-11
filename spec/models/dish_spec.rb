require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'validations' do
    context 'on creation' do
      it 'must have a name' do
        expect { Dish.create!(price: 10) }.to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'cannot have a name that starts with letter e' do
        expect { Dish.create!(name: 'eggs', price: 10.0) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { Dish.create!(name: 'Eggs', price: 10.0) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'must have a price' do
        expect { Dish.create!(name: 'spaghetti') }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'must have a numerical price' do
        expect { Dish.create!(name: 'spaghetti', price: 'hello') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'associations' do
    it { should have_one(:menu_dish).without_validating_presence }
  end

  context 'deletion' do
    before do
      menu = Menu.create!(name: 'Starters')
      dish = Dish.create!(name: 'Delete Me', price: 45)
      MenuDish.create!(dish: dish, menu: menu)
      @id = dish.id
      dish.destroy!
    end

    it 'is deleted' do
      expect do
        Dish.find(@id)
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'deletes all menu dishes' do
      expect(MenuDish.where(dish_id: @id).size).to eq(0)
    end
  end
end
