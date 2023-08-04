# spec/models/subcategory_spec.rb
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
end
