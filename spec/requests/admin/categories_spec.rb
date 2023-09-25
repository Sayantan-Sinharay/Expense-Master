# rubocop:disable all
require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin_user) { create(:user, is_admin?: true) }
  let(:category) { create(:category) }

  before { allow(controller).to receive(:authenticate_admin).and_return(true) }

  describe 'GET #index' do
    it 'assigns a new category and loads categories' do
      allow(Current).to receive(:user).and_return(admin_user)
      
      get :index

      expect(assigns(:category)).to be_a_new(Category)
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'POST #create' do
    context 'with valid category parameters' do
      it 'creates a new category and redirects to admin_categories_path' do
        allow(Current).to receive(:user).and_return(admin_user)

        post :create, params: { category: { name: 'New Category' } }

        expect(Category.count).to eq(1)
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid category parameters' do
      it 'renders the index template' do
        allow(Current).to receive(:user).and_return(admin_user)

        post :create, params: { category: { name: '' } }

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit.js.erb template' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :edit, params: { id: category.id }, format: :js

      expect(response).to render_template('admin/categories/edit')
    end
  end

  describe 'PATCH #update' do
    context 'with valid category parameters' do
      it 'updates the category and redirects to admin_categories_path' do
        allow(Current).to receive(:user).and_return(admin_user)

        patch :update, params: { id: category.id, category: { name: 'Updated Category' } }

        category.reload
        expect(category.name).to eq('Updated Category')
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid category parameters' do
      it 'renders the index template' do
        allow(Current).to receive(:user).and_return(admin_user)

        patch :update, params: { id: category.id, category: { name: '' } }

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the category and renders destroy.js.erb' do
      allow(Current).to receive(:user).and_return(admin_user)

      delete :destroy, params: { id: category.id }, format: :js

      expect(Category.count).to eq(0)
      expect(response).to render_template('admin/categories/destroy')
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
