# rubocop:disable all

require 'rails_helper'

RSpec.describe Users::BudgetsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up
  let(:budget) { create(:budget, user:) }  # Assuming you have a Budget model and FactoryBot set up
  let(:wallet) { create(:wallet, user:) }  # Assuming you have a Wallet model and FactoryBot set up
  let(:category) { create(:category) } # Assuming you have a Category model and FactoryBot set up
  # Assuming you have a Subcategory model and FactoryBot set up
  let(:subcategory) do
    create(:subcategory, category:)
  end
  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'assigns budgets and renders the index template' do
      allow(Current).to receive(:user).and_return(user)
      budgets = [budget]

      get :index

      expect(assigns(:budgets)).to eq(budgets)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new budget and renders the new template' do
      allow(Current).to receive(:user).and_return(user)

      get :new

      expect(assigns(:budget)).to be_a_new(Budget)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with a valid budget and wallet' do
      it 'creates a new budget, deducts amount from wallet, and redirects to budgets_path' do
        allow(Current).to receive(:user).and_return(user)
        allow(controller).to receive(:valid_wallet?).and_return(true)

        post :create,
             params: { budget: { category_id: category.id, amount: 100, month: Date.current.strftime('%Y-%m') } }

        expect(Budget.count).to eq(1)
        expect(flash[:success]).to eq('Budget created successfully.')
        expect(response).to redirect_to(budgets_path)
      end
    end

    context 'with an invalid wallet' do
      it 'renders the new template with an error message' do
        allow(Current).to receive(:user).and_return(user)
        allow(controller).to receive(:valid_wallet?).and_return(false)

        post :create,
             params: { budget: { category_id: category.id, amount: 100, month: Date.current.strftime('%Y-%m') } }

        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
