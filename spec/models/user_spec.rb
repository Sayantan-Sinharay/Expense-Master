# rubocop:disable all

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:organization) { create(:organization) }

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        user = build(:user, organization:)
        expect(user).to be_valid
      end
    end

    context 'without a first name' do
      it 'is not valid' do
        user = build(:user, first_name: nil, organization:)
        expect(user).not_to be_valid
        expect(user.errors[:first_name]).to include('User must have a first name')
      end
    end

    context 'without a valid email' do
      it 'is not valid' do
        user = build(:user, email: 'invalid_email', organization:)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include('Is not a valid email format')
      end
    end

    context 'with a last name exceeding 20 characters' do
      it 'is not valid' do
        user = build(:user, last_name: 'a' * 21, organization:)
        expect(user).not_to be_valid
        expect(user.errors[:last_name]).to include('Last name is too long.')
      end
    end

    context 'without a password' do
      it 'is not valid' do
        user = build(:user, password: nil, password_confirmation: nil, organization:)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("Can't be blank")
      end
    end

    context 'with a short password' do
      it 'is not valid' do
        user = build(:user, password: 'abc', password_confirmation: 'abc', organization:)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('Is too short (minimum is 8 characters)')
      end
    end

    context 'with a weak password' do
      it 'is not valid' do
        user = build(:user, password: 'Abc123', password_confirmation: 'Abc123', organization:)
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('Must include at least one lowercase letter, one uppercase letter, one digit, and one special character')
      end
    end

    context 'with a strong password' do
      it 'is valid' do
        user = build(:user, password: 'Abc123$%^', password_confirmation: 'Abc123$%^', organization:)
        expect(user).to be_valid
      end
    end

    context 'when password confirmation does not match password' do
      it 'is not valid' do
        user = build(:user, password: 'Abc123$%^', password_confirmation: 'DifferentPassword',
                            organization:)
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end

  describe 'associations' do
    it 'creates budgets associated with the user' do
      user = create(:user, organization:)
      budget = create(:budget, user:)
      expect(user.budgets).to include(budget)
    end

    it 'returns non-admin users for a given organization' do
      admin_user = create(:user, is_admin?: true, organization:)
      non_admin_user = create(:user, organization:)
      expect(User.get_non_admin_users(organization.id)).to include(non_admin_user)
      expect(User.get_non_admin_users(organization.id)).not_to include(admin_user)
    end

    it 'returns admin users for a given organization' do
      admin_user = create(:user, is_admin?: true, organization:)
      non_admin_user = create(:user, organization:)
      expect(User.get_admin_users(organization.id)).to include(admin_user)
      expect(User.get_admin_users(organization.id)).not_to include(non_admin_user)
    end
  end

  describe '.generate_password' do
    it 'generates passwords that match the regex pattern' do
      regex_pattern = User::PASSWORD_REGEX

      100.times do
        generated_password = User.generate_password
        expect(generated_password).to match(regex_pattern)
      end
    end
  end

  describe '.create_user' do
    it 'creates a user with a generated password' do
      admin_user = create(:user, organization:)
      new_staff = admin_user.organization.users.build(email: 'staff@example.com')
      invited_user = User.create_user(new_staff)

      expect(invited_user).to be_valid
      expect(invited_user.organization_id).to eq(admin_user.organization_id)
      expect(invited_user.authenticate(invited_user.password)).to be_truthy
    end
  end
end
