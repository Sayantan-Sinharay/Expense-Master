# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:organization) { create(:organization) }

  it 'is valid with valid attributes' do
    user = build(:user, organization: organization)
    expect(user).to be_valid
  end

  it 'is not valid without a first name' do
    user = build(:user, first_name: nil, organization: organization)
    expect(user).not_to be_valid
  end

  it 'is not valid without a valid email' do
    user = build(:user, email: 'invalid_email', organization: organization)
    expect(user).not_to be_valid
  end

  it 'creates budgets associated with the user' do
    user = create(:user)
    budget = create(:budget, user: user)
  
    expect(user.budgets).to include(budget)
  end
end
