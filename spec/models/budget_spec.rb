# rubocop:disable all

require 'rails_helper'

RSpec.describe Budget, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:subcategory, category:) }

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        budget = build(:budget, user:, category:, subcategory:)
        expect(budget).to be_valid
      end
    end

    context 'without a category' do
      it 'is not valid' do
        budget = build(:budget, user:, category: nil)
        expect(budget).not_to be_valid
        expect(budget.errors[:category]).to include('Category must be selected')
      end
    end

    context 'without an amount' do
      it 'is not valid' do
        budget = build(:budget, user:, category:, amount: nil)
        expect(budget).not_to be_valid
        expect(budget.errors[:amount]).to include("Amount can't be blank")
      end
    end

    context 'with a negative amount' do
      it 'is not valid' do
        budget = build(:budget, user:, category:, amount: -50)
        expect(budget).not_to be_valid
        expect(budget.errors[:amount]).to include('Amount must be greater than 0')
      end
    end

    context 'without notes' do
      it 'is valid' do
        budget = build(:budget, user:, category:, notes: nil)
        expect(budget).to be_valid
      end
    end

    context 'without subcategory' do
      it 'is valid' do
        budget = build(:budget, user:, category:, subcategory: nil)
        expect(budget).to be_valid
      end
    end

    context 'without a month' do
      it 'is not valid' do
        budget = build(:budget, user:, category:, month: nil)
        expect(budget).not_to be_valid
        expect(budget.errors[:month]).to include('Month must be selected')
      end
    end

    context 'with notes exceeding maximum length' do
      it 'is not valid' do
        long_notes = 'a' * 256
        budget = build(:budget, user:, category:, notes: long_notes)
        expect(budget).not_to be_valid
        expect(budget.errors[:notes]).to include('Please give a brief note (maximum is 255 characters)')
      end
    end

    context 'with a month outside the valid range' do
      it 'is not valid' do
        budget = build(:budget, user:, category:, month: 13)
        expect(budget).not_to be_valid
        expect(budget.errors[:month]).to include('Month must be between 1 and 12')
      end
    end
  end

  describe 'associations' do
    it 'is associated with a user' do
      budget = create(:budget, user:, category:, subcategory:)
      expect(budget.user).to eq(user)
    end

    it 'is associated with a category' do
      budget = create(:budget, user:, category:, subcategory:)
      expect(budget.category).to eq(category)
    end

    it 'is associated with a subcategory' do
      budget = create(:budget, user:, category:, subcategory:)
      expect(budget.subcategory).to eq(subcategory)
    end
  end
end
