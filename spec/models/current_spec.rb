# rubocop:disable all

require 'rails_helper'

RSpec.describe Current, type: :model do
  describe '.user' do
    it 'returns the current user attribute' do
      user = create(:user)
      Current.user = user

      expect(Current.user).to eq(user)
    end
  end

  describe '.user=' do
    it 'sets the current user attribute' do
      user = create(:user)
      Current.user = user

      expect(Current.user).to eq(user)
    end
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
