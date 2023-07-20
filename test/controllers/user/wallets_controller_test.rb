# frozen_string_literal: true

require 'test_helper'

class User::WalletsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get user_wallets_index_url
    assert_response :success
  end
end
