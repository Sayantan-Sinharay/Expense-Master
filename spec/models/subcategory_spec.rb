# rubocop:disable all

require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  it 'is valid with valid attributes' do
    subcategory = build(:subcategory)
    expect(subcategory).to be_valid
  end

  it 'is not valid without a name' do
    subcategory = build(:subcategory, name: nil)
    expect(subcategory).not_to be_valid
  end

  it 'is not valid with a duplicate name within the same category' do
    existing_subcategory = create(:subcategory)
    new_subcategory = build(:subcategory, name: existing_subcategory.name, category: existing_subcategory.category)
    expect(new_subcategory).not_to be_valid
  end

  it 'is not valid with a duplicate name within a different category' do
    existing_subcategory = create(:subcategory)
    new_category = create(:category)
    new_subcategory = build(:subcategory, name: existing_subcategory.name, category: new_category)
    expect(new_subcategory).to be_valid
  end
  
  it 'can have associated budgets' do
    subcategory = create(:subcategory)
    budget = create(:budget, subcategory: subcategory)
    expect(subcategory.budgets).to include(budget)
  end
  
  it 'can have associated expenses' do
    subcategory = create(:subcategory)
    expense = create(:expense, subcategory: subcategory)
    expect(subcategory.expenses).to include(expense)
  end
end
