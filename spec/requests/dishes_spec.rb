require 'rails_helper'

RSpec.describe 'Dishes', type: :request do
  describe 'index' do
    it 'renders the index template' do
      get '/dishes'
      expect(response).to render_template(:index)
    end

    context 'json format' do
      before do
        @dish = Dish.create!(name: 'Soup', price: 99)
      end
      it 'renders all dishes on json' do
        get '/dishes.json'
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'new' do
    it 'renders the new template' do
      get '/dishes/new'
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    before do
      post '/dishes', params: { dish: { name: 'TestCreate', price: 45 } }
      @response = response
    end

    it 'creates the new dish' do
      expect(Dish.find_by(name: 'TestCreate')).not_to be_nil
    end

    it 'redirects to details' do
      expect(@response).to redirect_to(assigns(:dish))
      follow_redirect!
      expect(@response).to render_template(:show)
    end
  end

  describe 'update' do
    before do
      @dish = Dish.create!(name: 'Test Update', price: 34)
      put "/dishes/#{@dish.id}", params: { dish: { name: 'Updated!'}}
      @response = response
    end

    it 'updates the dish' do
      expect(Dish.find(@dish.id).name).to eq('Updated!')
    end

    it 'redirects to details page' do
      expect(@response).to redirect_to(assigns(:dish))
      follow_redirect!
      expect(@response).to render_template(:show)
    end
  end

  describe 'destroy' do
    before do
      @dish = Dish.create!(name: 'Test Destroy', price: 1)
      delete "/dishes/#{@dish.id}"
      @response = response
    end

    it 'deletes the dish' do
      expect do 
        Dish.find(@dish.id)
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'redirects to index' do
      expect(@response).to redirect_to(assigns(:dish))
      follow_redirect!
      expect(@response).to render_template(:index)
    end
  end
end
