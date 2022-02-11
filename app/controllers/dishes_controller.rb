class DishesController < ApplicationController
  before_action :current_dish, only: %i[show edit update destroy]

  def index
    @dishes = Dish.all

    respond_to do |format|
      format.html
      format.json { render json: DishBlueprint.render(@dishes) }
    end
  end

  def show; end

  def new
    @dish = Dish.new
  end

  def create
    ActiveRecord::Base.transaction do
      @dish = Dish.new(dish_params.except(:menu_id))
      has_menu = dish_params[:menu_id] && dish_params[:menu_id]&.to_i&.positive?
      if has_menu
        menu_dish = MenuDish.new(dish: @dish, menu_id: dish_params[:menu_id])
        menu_dish.save
      end

      if @dish.save
        redirect_to dish_path(@dish)
      else
        render :new
      end
    end
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @dish.update!(dish_params.except(:menu_id))
      if dish_params[:menu_id] && dish_params[:menu_id]&.to_i&.positive?
        new_menu_dish = MenuDish.find_or_initialize_by(dish_id: @dish.id)
        new_menu_dish.menu_id = dish_params[:menu_id]
        new_menu_dish.save!
      elsif @dish.menu_dish
        @dish.menu_dish.destroy
      end
    end

    redirect_to dish_path(@dish)
  end

  def destroy
    @dish.destroy

    redirect_to dishes_path
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :price, :menu_id)
  end

  def current_dish
    @dish = Dish.find(params[:id])
  end
end
