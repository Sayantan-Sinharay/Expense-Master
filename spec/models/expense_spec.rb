# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  it 'is valid with valid attributes' do
    expense = build(:expense, user: user, category: category)
    expect(expense).to be_valid
  end

  it 'is not valid without a category' do
    expense = build(:expense, user: user, category: nil)
    expect(expense).not_to be_valid
  end

  it 'is not valid without a date' do
    expense = build(:expense, user: user, category: category, date: nil)
    expect(expense).not_to be_valid
  end

  # Add more tests for other attributes, validations, and associations
end
