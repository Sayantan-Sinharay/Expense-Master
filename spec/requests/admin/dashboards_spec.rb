# rubocop:disable all

require 'rails_helper'

RSpec.describe Admin::DashboardsController, type: :controller do
  let(:admin_user) { create(:user, is_admin?: true) } # Assuming you have a User model and FactoryBot set up
  let(:expense) { create(:expense) } # Assuming you have an Expense model and FactoryBot set up

  before { allow(controller).to receive(:authenticate_admin).and_return(true) }

  describe 'GET #index' do
    it 'assigns expenses and renders the index template' do
      allow(Current).to receive(:user).and_return(admin_user)
      expenses = [expense]

      get :index

      expect(assigns(:expenses)).to eq(expenses)
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #approved' do
    it 'approves the expense and sends notification' do
      allow(Current).to receive(:user).and_return(admin_user)
      allow(controller).to receive(:send_expense_status_update_notification)

      post :approved, params: { id: expense.id }

      expense.reload
      expect(expense.status).to eq('approved')
      expect(controller).to have_received(:send_expense_status_update_notification).once
      expect(flash[:success]).to eq('Expense approved successfully.')
      expect(response).to redirect_to(admin_dashboards_path)
    end
  end

  describe 'GET #reject' do
    it 'renders the reject.js.erb template' do
      allow(Current).to receive(:user).and_return(admin_user)

      get :reject, params: { id: expense.id }, format: :js

      expect(response).to render_template('admin/dashboards/reject')
    end
  end

  describe 'PATCH #rejected' do
    context 'with valid rejection reason' do
      it 'rejects the expense, sends notification, and redirects' do
        allow(Current).to receive(:user).and_return(admin_user)
        allow(controller).to receive(:send_expense_status_update_notification)

        patch :rejected, params: { id: expense.id, expense: { rejection_reason: 'Invalid receipt' } }

        expense.reload
        expect(expense.status).to eq('rejected')
        expect(expense.rejection_reason).to eq('Invalid receipt')
        expect(controller).to have_received(:send_expense_status_update_notification).once
        expect(flash[:danger]).to eq('Expense rejected successfully')
        expect(response).to redirect_to(admin_dashboards_path)
      end
    end

    context 'with invalid rejection reason' do
      it 'renders the reject.js.erb template' do
        allow(Current).to receive(:user).and_return(admin_user)

        patch :rejected, params: { id: expense.id, expense: { rejection_reason: '' } }, format: :js

        expect(response).to render_template('admin/dashboards/reject')
      end
    end
  end
end
