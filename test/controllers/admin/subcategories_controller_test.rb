# frozen_string_literal: true

require 'test_helper'

module Admin
  class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get admin_subcategories_index_url
      assert_response :success
    end

    test 'should get new' do
      get admin_subcategories_new_url
      assert_response :success
    end

    test 'should get create' do
      get admin_subcategories_create_url
      assert_response :success
    end

    test 'should get edit' do
      get admin_subcategories_edit_url
      assert_response :success
    end

    test 'should get update' do
      get admin_subcategories_update_url
      assert_response :success
    end

    test 'should get destroy' do
      get admin_subcategories_destroy_url
      assert_response :success
    end
  end
end
