# spec/models/wallet_spec.rb
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    wallet = build(:wallet, user: user)
    expect(wallet).to be_valid
  end

  it 'is not valid without an amount' do
    wallet = build(:wallet, user: user, amount: nil)
    expect(wallet).not_to be_valid
  end

  it 'is not valid without a month' do
    wallet = build(:wallet, user: user, month: nil)
    expect(wallet).not_to be_valid
  end

  # Add more tests for other attributes, validations, and associations
end
