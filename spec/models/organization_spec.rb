# rubocop:disable all

require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'is valid with valid attributes' do
    organization = build(:organization)
    expect(organization).to be_valid
  end

  it 'is not valid without a name' do
    organization = build(:organization, name: nil)
    expect(organization).not_to be_valid
    expect(organization.errors[:name]).to include("Organization name can't be blank")
  end

  it 'is not valid with a duplicate name' do
    existing_organization = create(:organization)
    new_organization = build(:organization, name: existing_organization.name)
    expect(new_organization).not_to be_valid
    expect(new_organization.errors[:name]).to include('Organization name must be unique')
  end

  it 'is not valid with a name containing invalid characters' do
    organization = build(:organization, name: 'Invalid@Org')
    expect(organization).not_to be_valid
    expect(organization.errors[:name]).to include('Organization name is invalid')
  end

  it 'is not valid with a name shorter than 2 characters' do
    organization = build(:organization, name: 'A')
    expect(organization).not_to be_valid
    expect(organization.errors[:name]).to include('Organization name must be between 2 and 50 characters')
  end

  it 'is not valid with a name longer than 50 characters' do
    organization = build(:organization, name: 'A' * 51)
    expect(organization).not_to be_valid
    expect(organization.errors[:name]).to include('Organization name must be between 2 and 50 characters')
  end
end
