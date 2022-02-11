class MenusController < ApplicationController
  before_action :current_menu, only: %i[show edit update destroy]

  def index
    @menus = Menu.all

    respond_to do |format|
      format.html
      format.json { render json: MenuBlueprint.render(@menus) }
    end
  end

  def show; end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      redirect_to menu_path(@menu)
    else
      render :new
    end
  end

  def edit; end

  def update
    @menu.update!(menu_params)

    redirect_to menu_path(@menu)
  end

  def destroy
    @menu.destroy

    redirect_to menus_path
  end

  private

  def menu_params
    params.require(:menu).permit(:name)
  end

  def current_menu
    @menu = Menu.find(params[:id])
  end
end
