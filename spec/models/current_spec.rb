# rubocop:disable all

require 'rails_helper'

RSpec.describe Current, type: :model do
  describe '.user' do
    context 'when setting and accessing the current user' do
      it 'returns the current user attribute' do
        user = create(:user)
        Current.user = user

        expect(Current.user).to eq(user)
      end

      it 'does not share user attribute between examples' do
        user1 = create(:user)
        user2 = create(:user)

        Current.user = user1
        expect(Current.user).to eq(user1)

        Current.user = user2
        expect(Current.user).to eq(user2)
      end
    end
  end

  describe '.user=' do
    context 'when setting the current user attribute' do
      it 'sets the current user attribute' do
        user = create(:user)
        Current.user = user

        expect(Current.user).to eq(user)
      end
    end
  end
end
