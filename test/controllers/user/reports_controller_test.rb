# frozen_string_literal: true

require 'test_helper'

module User
  class ReportsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get user_reports_index_url
      assert_response :success
    end
  end
end
