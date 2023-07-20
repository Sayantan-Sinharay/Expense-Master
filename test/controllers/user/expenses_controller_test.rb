# frozen_string_literal: true

require 'test_helper'

class User::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get user_expenses_index_url
    assert_response :success
  end

  test 'should get new' do
    get user_expenses_new_url
    assert_response :success
  end

  test 'should get create' do
    get user_expenses_create_url
    assert_response :success
  end

  test 'should get show' do
    get user_expenses_show_url
    assert_response :success
  end

  test 'should get edit' do
    get user_expenses_edit_url
    assert_response :success
  end

  test 'should get update' do
    get user_expenses_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get user_expenses_destroy_url
    assert_response :success
  end

  test 'should get approve' do
    get user_expenses_approve_url
    assert_response :success
  end

  test 'should get reject' do
    get user_expenses_reject_url
    assert_response :success
  end
end
