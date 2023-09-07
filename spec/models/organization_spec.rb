# rubocop:disable all

require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        organization = build(:organization)
        expect(organization).to be_valid
      end
    end

    context 'without a name' do
      it 'is not valid' do
        organization = build(:organization, name: nil)
        expect(organization).not_to be_valid
        expect(organization.errors[:name]).to include("Organization name can't be blank")
      end
    end

    context 'with a duplicate name' do
      it 'is not valid' do
        existing_organization = create(:organization)
        new_organization = build(:organization, name: existing_organization.name)
        expect(new_organization).not_to be_valid
        expect(new_organization.errors[:name]).to include('Organization name must be unique')
      end
    end

    context 'with a name containing invalid characters' do
      it 'is not valid' do
        organization = build(:organization, name: 'Invalid@Org')
        expect(organization).not_to be_valid
        expect(organization.errors[:name]).to include('Organization name is invalid')
      end
    end

    context 'with a name shorter than 2 characters' do
      it 'is not valid' do
        organization = build(:organization, name: 'A')
        expect(organization).not_to be_valid
        expect(organization.errors[:name]).to include('Organization name must be between 2 and 50 characters')
      end
    end

    context 'with a name longer than 50 characters' do
      it 'is not valid' do
        organization = build(:organization, name: 'A' * 51)
        expect(organization).not_to be_valid
        expect(organization.errors[:name]).to include('Organization name must be between 2 and 50 characters')
      end
    end
  end
end
