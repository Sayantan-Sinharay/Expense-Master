# spec/models/budget_spec.rb
require 'rails_helper'

RSpec.describe Budget, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:subcategory, category: category) }

  it 'is valid with valid attributes' do
    budget = build(:budget, user: user, category: category, subcategory: subcategory)
    expect(budget).to be_valid
  end

  it 'is not valid without a category' do
    budget = build(:budget, user: user, category: nil)
    expect(budget).not_to be_valid
    expect(budget.errors[:category]).to include("Category must be selected")
  end

  it 'is not valid without an amount' do
    budget = build(:budget, user: user, category: category, amount: nil)
    expect(budget).not_to be_valid
    expect(budget.errors[:amount]).to include("Amount can't be blank")
  end

  it 'is not valid with a negative amount' do
    budget = build(:budget, user: user, category: category, amount: -50)
    expect(budget).not_to be_valid
    expect(budget.errors[:amount]).to include("Amount must be greater than or equal to 0")
  end

  it 'is valid without notes' do
    budget = build(:budget, user: user, category: category, notes: nil)
    expect(budget).to be_valid
  end

  it 'is valid without subcategory' do
    budget = build(:budget, user: user, category: category, subcategory: nil)
    expect(budget).to be_valid
  end

  it 'is not valid without a month' do
    budget = build(:budget, user: user, category: category, month: nil)
    expect(budget).not_to be_valid
    expect(budget.errors[:month]).to include("Month must be selected")
  end
end
