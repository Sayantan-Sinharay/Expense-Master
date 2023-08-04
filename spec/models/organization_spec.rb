# spec/models/organization_spec.rb
require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'is valid with valid attributes' do
    organization = build(:organization)
    expect(organization).to be_valid
  end

  it 'is not valid without a name' do
    organization = build(:organization, name: nil)
    expect(organization).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    existing_organization = create(:organization)
    new_organization = build(:organization, name: existing_organization.name)
    expect(new_organization).not_to be_valid
  end

  it 'is not valid with a name shorter than 1 character' do
    organization = build(:organization, name: '')
    expect(organization).not_to be_valid
  end
end
