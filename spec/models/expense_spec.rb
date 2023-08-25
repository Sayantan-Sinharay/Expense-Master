# rubocop:disable all

require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:subcategory, category:) }

  it 'is valid with valid attributes' do
    expense = build(:expense, user:, category:)
    expect(expense).to be_valid
  end

  it 'is not valid without a category' do
    expense = build(:expense, user:, category: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:category]).to include('Category must be selected')
  end

  it 'is not valid without a date' do
    expense = build(:expense, user:, category:, date: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:date]).to include("Date can't be blank")
  end

  it 'is not valid without an amount' do
    expense = build(:expense, user:, category:, amount: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:amount]).to include("Amount can't be blank")
  end

  it 'is not valid with a non-positive amount' do
    expense = build(:expense, user:, category:, amount: -50)
    expect(expense).not_to be_valid
    expect(expense.errors[:amount]).to include('Amount must be greater than 0')
  end

  it 'is valid without notes' do
    expense = build(:expense, user:, category:, notes: nil)
    expect(expense).to be_valid
  end

  it 'can have an attachment' do
    expense = create(:expense, user:, category:)
    expense.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.pdf')), filename: 'sample.pdf',
                              content_type: 'application/pdf')
    expect(expense.attachment).to be_attached
  end

  it 'can have a status of pending, approved, or rejected' do
    pending_expense = create(:expense, user:, category:, status: 'pending')
    approved_expense = create(:expense, user:, category:, status: 'approved')
    rejected_expense = create(:expense, user:, category:, status: 'rejected')

    expect(pending_expense.pending?).to be true
    expect(approved_expense.approved?).to be true
    expect(rejected_expense.rejected?).to be true
  end

  it 'can be scoped to get approved expenses for a user' do
    approved_expense = create(:expense, user:, category:, status: 'approved')
    pending_expense = create(:expense, user:, category:, status: 'pending')
    other_user_expense = create(:expense, user: create(:user), category:, status: 'approved')

    approved_expenses = Expense.get_approved_expenses(user)
    expect(approved_expenses).to include(approved_expense)
    expect(approved_expenses).not_to include(pending_expense)
    expect(approved_expenses).not_to include(other_user_expense)
  end

  it 'can have a subcategory' do
    expense = build(:expense, user:, category:, subcategory:)
    expect(expense).to be_valid
  end

  it 'is valid without subcategory' do
    expense = build(:expense, user:, category:, subcategory: nil)
    expect(expense).to be_valid
  end

  it 'can have an attachment with valid content type png' do
    expense = create(:expense, user:, category:)
    expense.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.png')), filename: 'sample.png',
                              content_type: 'image/png')
    expect(expense.attachment).to be_attached
  end

  it 'can have an attachment with valid content type jpeg' do
    expense = create(:expense, user:, category:)
    expense.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.jpeg')), filename: 'sample.jpeg',
                              content_type: 'image/jpeg')
    expect(expense.attachment).to be_attached
  end

  it 'cannot have an attachment with invalid content type' do
    expense = build(:expense, user:, category:)
    expense.attachment.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample.txt')), filename: 'sample.txt',
                              content_type: 'text/plain')
    expect(expense).not_to be_valid
    expect(expense.errors[:attachment]).to include('Attachment content type is invalid')
  end

  it 'can have a status of "pending", "approved", or "rejected"' do
    expect(Expense.statuses.keys).to include('pending', 'approved', 'rejected')
  end

  it 'can be scoped to get expenses within a specific date range' do
    expense_in_range = create(:expense, user:, category:, date: Date.today)
    expense_out_of_range = create(:expense, user:, category:, date: Date.today - 1.year)

    expenses_within_range = Expense.where(date: Date.today - 1.month..Date.today)
    expect(expenses_within_range).to include(expense_in_range)
    expect(expenses_within_range).not_to include(expense_out_of_range)
  end

  it 'is not valid with rejected status and blank rejection reason' do
    expense = create(:expense, user:, category:, status: 'rejected', rejection_reason: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:rejection_reason]).to include('Rejection reason cannot be blank')
  end

  it 'is not valid with rejected status and too long rejection reason' do
    long_reason = 'a' * 256
    expense = build(:expense, user:, category:)
    expense.update(status: 'rejected', rejection_reason: long_reason)
    expect(expense).not_to be_valid
    expect(expense.errors[:rejection_reason]).to include('Rejection reason should be brief')
  end

  it 'is valid with rejected status and valid rejection reason' do
    valid_reason = 'This expense is not within the budget'
    expense = build(:expense, user:, category:, status: 'rejected', rejection_reason: valid_reason)
    expect(expense).to be_valid
  end

  it 'can be scoped to get expenses within a specific organization' do
    organization = create(:organization)
    user_in_org = create(:user, organization:)
    user_outside_org = create(:user)
    expense_in_org = create(:expense, user: user_in_org, category:)
    expense_outside_org = create(:expense, user: user_outside_org, category:)

    org_expenses = Expense.expense_at_organization(organization)
    expect(org_expenses).to include(expense_in_org)
    expect(org_expenses).not_to include(expense_outside_org)
  end
end
