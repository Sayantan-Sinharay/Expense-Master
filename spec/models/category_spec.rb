# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    category = build(:category)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = build(:category, name: nil)
    expect(category).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    existing_category = create(:category)
    new_category = build(:category, name: existing_category.name)
    expect(new_category).not_to be_valid
  end
end
