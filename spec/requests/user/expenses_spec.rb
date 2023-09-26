# rubocop:disable all

require 'rails_helper'

RSpec.describe Users::ExpensesController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up
  let(:expense) { create(:expense, user:) } # Assuming you have an Expense model and FactoryBot set up
  let(:category) { create(:category) } # Assuming you have a Category model and FactoryBot set up
  # Assuming you have a Subcategory model and FactoryBot set up
  let(:subcategory) do
    create(:subcategory, category:)
  end
  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'assigns expenses and renders the index template' do
      allow(Current).to receive(:user).and_return(user)
      expenses = [expense]

      get :index

      expect(assigns(:expenses)).to eq(expenses)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new expense and renders the new template' do
      allow(Current).to receive(:user).and_return(user)

      get :new

      expect(assigns(:expense)).to be_a_new(Expense)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with a valid expense' do
      it 'creates a new expense, attaches attachment, and redirects to expenses_path' do
        allow(Current).to receive(:user).and_return(user)

        post :create,
             params: { expense: { category_id: category.id, amount: 100, date: Date.current,
                                  attachment: fixture_file_upload('../../fixtures/sample.jpeg') } }

        expect(Expense.count).to eq(1)
        expect(flash[:success]).to eq('Expense created successfully.')
        expect(response).to redirect_to(expenses_path)
      end
    end

    context 'with an invalid expense' do
      it 'renders the new template with an error message' do
        allow(Current).to receive(:user).and_return(user)

        post :create, params: { expense: { category_id: category.id, amount: -100, date: Date.current } }

        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
