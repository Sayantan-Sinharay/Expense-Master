# frozen_string_literal: true

require 'test_helper'

module User
  class BudgetsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get user_budgets_index_url
      assert_response :success
    end

    test 'should get new' do
      get user_budgets_new_url
      assert_response :success
    end

    test 'should get create' do
      get user_budgets_create_url
      assert_response :success
    end

    test 'should get show' do
      get user_budgets_show_url
      assert_response :success
    end

    test 'should get edit' do
      get user_budgets_edit_url
      assert_response :success
    end

    test 'should get update' do
      get user_budgets_update_url
      assert_response :success
    end

    test 'should get destroy' do
      get user_budgets_destroy_url
      assert_response :success
    end
  end
end
