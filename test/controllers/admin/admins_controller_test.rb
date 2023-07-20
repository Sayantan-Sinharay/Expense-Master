# frozen_string_literal: true

require 'test_helper'

module Admin
  class AdminsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get admin_admins_index_url
      assert_response :success
    end
  end
end
