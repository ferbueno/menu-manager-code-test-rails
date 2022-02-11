require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'associations' do
    it { should have_many(:menu_dishes).without_validating_presence }
    it { should have_many(:dishes).without_validating_presence }
  end

  describe 'validations' do
    it 'must have a name' do
      expect { Menu.new.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'deletion' do
    before do
      menu = Menu.create!(name: 'Delete Me')
      dish = Dish.create!(name: 'Salad', price: 45)
      MenuDish.create!(dish: dish, menu: menu)
      @id = menu.id
      menu.destroy!
    end

    it 'is deleted' do
      expect do
        Menu.find(@id)
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'deletes all menu dishes' do
      expect(MenuDish.where(menu_id: @id).size).to eq(0)
    end
  end
end
