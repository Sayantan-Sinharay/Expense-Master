# rubocop:disable all

require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    wallet = build(:wallet, user:)
    expect(wallet).to be_valid
  end

  it 'is not valid without an amount' do
    wallet = build(:wallet, user:, amount: nil)
    expect(wallet).not_to be_valid
    expect(wallet.errors[:amount]).to include("Amount can't be blank")
  end

  it 'is not valid with a negative amount' do
    wallet = build(:wallet, user:, amount: -50)
    expect(wallet).not_to be_valid
    expect(wallet.errors[:amount]).to include('Amount must be greater than or equal to 0')
  end

  it 'is not valid without a month' do
    wallet = build(:wallet, user:, month: nil)
    expect(wallet).not_to be_valid
    expect(wallet.errors[:month]).to include("Month can't be blank")
  end

  it 'is not valid with a duplicate month for the same user at same year' do
    existing_wallet = create(:wallet, user:, year: Date.current.year)
    new_wallet = build(:wallet, user:, month: existing_wallet.month, year: existing_wallet.year)
    expect(new_wallet).not_to be_valid
    expect(new_wallet.errors[:month]).to include('Wallet for this month already exists')
  end

  it 'is valid with a duplicate month for the same user at different year' do
    existing_wallet = create(:wallet, user:, year: Date.current.year)
    new_wallet = build(:wallet, user:, month: existing_wallet.month, year: existing_wallet.year + 1)
    expect(new_wallet).to be_valid
  end

  it 'is associated with a user' do
    wallet = create(:wallet, user:)
    expect(wallet.user).to eq(user)
  end

  it 'can be scoped to get wallets for the current year' do
    wallet_in_current_year = create(:wallet, user:, year: Date.current.year)
    wallet_in_previous_year = create(:wallet, user:, year: Date.current.year - 1)

    wallets = Wallet.current_year
    expect(wallets).to include(wallet_in_current_year)
    expect(wallets).not_to include(wallet_in_previous_year)
  end

  it 'can be scoped to get wallets for the given month and user' do
    wallet_in_july = create(:wallet, user:, month: 7)
    wallet_in_august = create(:wallet, user:, month: 8)
    wallet_of_another_user = create(:wallet, month: 7)

    wallets = Wallet.at_month(user, 7)
    expect(wallets).to include(wallet_in_july)
    expect(wallets).not_to include(wallet_in_august, wallet_of_another_user)
  end

  it 'can calculate the total amount in wallets for the current year and user' do
    create(:wallet, user:, amount: 100, year: Date.current.year)
    create(:wallet, user:, amount: 200, year: Date.current.year)
    create(:wallet, user:, amount: 300, year: Date.current.year - 1)

    total_amount = Wallet.total_amount_for_current_year(user)
    expect(total_amount).to eq(300) # 100 + 200
  end
end
