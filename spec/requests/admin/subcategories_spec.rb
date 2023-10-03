# rubocop:disable all

require 'rails_helper'

RSpec.describe Admin::SubcategoriesController, type: :controller do
  let(:organization) {create(:organization)}
  let(:admin_user) { create(:user, organization: ,is_admin?: true) } # Assuming you have a User model and FactoryBot set up
  let(:category) { create(:category, organization:) } # Assuming you have a Category model and FactoryBot set up
  # Assuming you have a Subcategory model and FactoryBot set up
  let(:subcategory) do
    create(:subcategory, category:)
  end
  before { allow(controller).to receive(:authenticate_admin).and_return(true) }

  describe 'GET #index' do
    it 'assigns subcategories and renders the index template' do
      allow(Current).to receive(:user).and_return(admin_user)
      subcategories = [subcategory]

      get :index, params: { category_id: category.id }

      expect(assigns(:subcategories)).to eq(subcategories)
      expect(response).to render_template('admin/subcategories/_subcategory')
    end

    it 'renders JSON format when requested' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :index, params: { category_id: category.id, format: :json }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'GET #new' do
    it 'assigns a new subcategory and renders the new.js.erb template' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :new, params: { category_id: category.id }, format: :js

      expect(assigns(:subcategory)).to be_a_new(Subcategory)
      expect(response).to render_template('admin/subcategories/new')
    end
  end

  describe 'POST #create' do
    context 'with valid subcategory parameters' do
      it 'creates a new subcategory and redirects to admin_categories_path' do
        allow(Current).to receive(:user).and_return(admin_user)

        post :create, params: { category_id: category.id, subcategory: { name: 'New Subcategory' } }

        expect(Subcategory.count).to eq(1)
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid subcategory parameters' do
      it 'renders the error_create.js.erb template' do
        allow(Current).to receive(:user).and_return(admin_user)

        post :create, params: { category_id: category.id, subcategory: { name: '' } }, format: :js

        expect(response).to render_template('admin/subcategories/error_create')
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the subcategory and renders the edit.js.erb template' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :edit, params: { category_id: category.id, id: subcategory.id }, format: :js

      expect(assigns(:subcategory)).to eq(subcategory)
      expect(response).to render_template('admin/subcategories/edit')
    end
  end

  describe 'PATCH #update' do
    context 'with valid subcategory parameters' do
      it 'updates the subcategory and redirects to admin_categories_path' do
        allow(Current).to receive(:user).and_return(admin_user)

        patch :update,
              params: { category_id: category.id, id: subcategory.id, subcategory: { name: 'Updated Subcategory' } }

        subcategory.reload
        expect(subcategory.name).to eq('Updated Subcategory')
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context 'with invalid subcategory parameters' do
      it 'renders the error_create.js.erb template' do
        allow(Current).to receive(:user).and_return(admin_user)

        patch :update, params: { category_id: category.id, id: subcategory.id, subcategory: { name: '' } }, format: :js

        expect(response).to render_template('admin/subcategories/error_create')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the subcategory and renders destroy.js.erb' do
      allow(Current).to receive(:user).and_return(admin_user)

      delete :destroy, params: { category_id: category.id, id: subcategory.id }, format: :js

      expect(Subcategory.count).to eq(0)
      expect(response).to render_template('admin/subcategories/destroy')
    end
  end
end
