require 'rails_helper'

RSpec.describe "Menus", type: :request do
  describe 'index' do
    it 'renders the index template' do
      get '/menus'
      expect(response).to render_template(:index)
    end

    context 'json format' do
      before do
        @menu = Menu.create!(name: 'Starters')
      end
      it 'renders all menus on json' do
        get '/menus.json'
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'new' do
    it 'renders the new template' do
      get '/menus/new'
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    before do
      post '/menus', params: { menu: { name: 'MenuCreate' } }
      @response = response
    end

    it 'creates the new dish' do
      expect(Menu.find_by(name: 'MenuCreate')).not_to be_nil
    end

    it 'redirects to details' do
      expect(@response).to redirect_to(assigns(:menu))
      follow_redirect!
      expect(@response).to render_template(:show)
    end
  end

  describe 'update' do
    before do
      @menu = Menu.create!(name: 'Start Update')
      put "/menus/#{@menu.id}", params: { menu: { name: 'End Update'}}
      @response = response
    end

    it 'updates the dish' do
      expect(Menu.find(@menu.id).name).to eq('End Update')
    end

    it 'redirects to details page' do
      expect(@response).to redirect_to(assigns(:menu))
      follow_redirect!
      expect(@response).to render_template(:show)
    end
  end

  describe 'destroy' do
    before do
      @menu = Menu.create!(name: 'Deserts')
      delete "/menus/#{@menu.id}"
      @response = response
    end

    it 'deletes the dish' do
      expect do 
        Menu.find(@menu.id)
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'redirects to index' do
      expect(@response).to redirect_to(assigns(:menu))
      follow_redirect!
      expect(@response).to render_template(:index)
    end
  end
end
