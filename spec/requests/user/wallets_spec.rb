# rubocop:disable all

require 'rails_helper'

RSpec.describe Users::WalletsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up

  before { allow(controller).to receive(:authenticate_user).and_return(true) }

  describe 'GET #index' do
    it 'assigns wallets and total_amount and renders the index template' do
      allow(Current).to receive(:user).and_return(user)
      total_amount = 500 # Adjust this value based on your actual wallet data
      wallets = [create(:wallet, user:, amount: total_amount)]

      get :index

      expect(assigns(:wallets)).to eq(wallets)
      expect(assigns(:total_amount)).to eq(total_amount)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new wallet and renders the new template' do
      allow(Current).to receive(:user).and_return(user)

      get :new

      expect(assigns(:wallet)).to be_a_new(Wallet)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with a valid wallet' do
      it 'creates a new wallet and redirects to wallets_path' do
        allow(Current).to receive(:user).and_return(user)
        wallet_params = { amount: 500, month: Date.current.beginning_of_month }

        post :create, params: { wallet: wallet_params }

        expect(Wallet.count).to eq(1)
        expect(flash[:success]).to eq('Wallet created successfully.')
        expect(response).to redirect_to(wallets_path)
      end
    end

    context 'with an invalid wallet' do
      it 'renders the new template with an error message' do
        allow(Current).to receive(:user).and_return(user)

        post :create, params: { wallet: { amount: -100, month: Date.current.beginning_of_month } }

        expect(flash[:danger]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  # You can add more test cases as needed for other controller actions or scenarios.
end
