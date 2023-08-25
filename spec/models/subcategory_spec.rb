# rubocop:disable all

require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  let(:category) { create(:category) }

  it 'is valid with valid attributes' do
    subcategory = build(:subcategory, category:)
    expect(subcategory).to be_valid
  end

  it 'is not valid without a name' do
    subcategory = build(:subcategory, name: nil, category:)
    expect(subcategory).not_to be_valid
    expect(subcategory.errors[:name]).to include("Subcategory name can't be blank")
  end

  it 'is not valid with a name less than 2 characters' do
    subcategory = build(:subcategory, name: 'a', category:)
    expect(subcategory).not_to be_valid
    expect(subcategory.errors[:name]).to include('Subcategory name must be between 2 and 50 characters')
  end

  it 'is not valid with a name exceeding 50 characters' do
    long_name = 'a' * 51
    subcategory = build(:subcategory, name: long_name, category:)
    expect(subcategory).not_to be_valid
    expect(subcategory.errors[:name]).to include('Subcategory name must be between 2 and 50 characters')
  end

  it 'is not valid with a name containing invalid characters' do
    subcategory = build(:subcategory, name: 'Invalid@Sub')
    expect(subcategory).not_to be_valid
    expect(subcategory.errors[:name]).to include('Subcategory name is invalid')
  end

  it 'is not valid with a duplicate name within the same category' do
    existing_subcategory = create(:subcategory, category:)
    new_subcategory = build(:subcategory, name: existing_subcategory.name, category:)
    expect(new_subcategory).not_to be_valid
    expect(new_subcategory.errors[:name]).to include('Subcategory name must be unique within the same category')
  end

  it 'is valid with a duplicate name within a different category' do
    existing_subcategory = create(:subcategory, category:)
    new_category = create(:category)
    new_subcategory = build(:subcategory, name: existing_subcategory.name, category: new_category)
    expect(new_subcategory).to be_valid
  end

  it 'can have associated budgets' do
    subcategory = create(:subcategory, category:)
    budget = create(:budget, subcategory:)
    expect(subcategory.budgets).to include(budget)
  end

  it 'can have associated expenses' do
    subcategory = create(:subcategory, category:)
    expense = create(:expense, subcategory:)
    expect(subcategory.expenses).to include(expense)
  end
end
