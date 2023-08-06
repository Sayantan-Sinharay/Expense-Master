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
  end

  it 'is not valid without a month' do
    wallet = build(:wallet, user:, month: nil)
    expect(wallet).not_to be_valid
  end

end
