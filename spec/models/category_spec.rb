# rubocop:disable all

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    category = build(:category)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = build(:category, name: nil)
    expect(category).not_to be_valid
    expect(category.errors[:name]).to include("Category name can't be blank")
  end

  it 'is not valid with a name less than 5 characters' do
    category = build(:category, name: 'abcd')
    expect(category).not_to be_valid
    expect(category.errors[:name]).to include('Category name must be between 5 and 50 characters')
  end

  it 'is not valid with a name exceeding 50 characters' do
    long_name = 'a' * 51
    category = build(:category, name: long_name)
    expect(category).not_to be_valid
    expect(category.errors[:name]).to include('Category name must be between 5 and 50 characters')
  end

  it 'is not valid with a duplicate name within the same organization' do
    organization = create(:organization)
    existing_category = create(:category, organization:)
    new_category = build(:category, organization:, name: existing_category.name)

    expect(new_category).not_to be_valid
    expect(new_category.errors[:name]).to include('Category name must be unique')
  end

  it 'can have many subcategories' do
    category = create(:category)
    subcategory1 = create(:subcategory, category:)
    subcategory2 = create(:subcategory, category:)
    expect(category.subcategories).to eq([subcategory1, subcategory2])
  end

  it 'can have many budgets' do
    category = create(:category)
    budget1 = create(:budget, category:)
    budget2 = create(:budget, category:)
    expect(category.budgets).to eq([budget1, budget2])
  end

  it 'can have many expenses' do
    category = create(:category)
    expense1 = create(:expense, category:)
    expense2 = create(:expense, category:)
    expect(category.expenses).to eq([expense1, expense2])
  end

  it 'belongs to an organization' do
    organization = create(:organization)
    category = create(:category, organization:)
    expect(category.organization).to eq(organization)
  end
end
