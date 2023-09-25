# frozen_string_literal: true

module Admin
  # Controller for managing categories in the admin panel.
  class CategoriesController < ApplicationController
    before_action :authenticate_admin
    before_action :set_categories, only: [:index]
    before_action :set_category, only: %i[edit update destroy]

    include NotificationsHelper

    def index
      @category = Category.new
    end

    def create
      @category = Current.user.organization.categories.new(category_params)
      respond_to do |format|
        if @category.save
          handle_valid_category(format)
        else
          handle_invalid_category(format)
        end
      end
    end

    def edit
      respond_to(&:js)
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          handle_valid_update(format)
        else
          handle_invalid_update(format)
        end
      end
    end

    def destroy
      flash = { danger: 'Category destroyed successfully.' }
      send_flash(Current.user, flash) if @category.destroy
      respond_to(&:js)
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def set_categories
      @categories = Current.user.organization.categories.order(created_at: :desc).all
    end

    def handle_valid_category(format)
      flash = { success: 'Category successfully created.' }
      send_flash(Current.user, flash)
      format.html { redirect_to admin_categories_path }
      format.js
    end

    def handle_invalid_category(format)
      format.html { render :index }
      format.js { render :error_create } # look into this later
    end

    def handle_valid_update(format)
      flash = { success: 'Category updated successfully.' }
      send_flash(Current.user, flash)
      format.html { redirect_to admin_categories_path }
      format.js
    end

    def handle_invalid_update(format)
      flash = { danger: 'Failed to update category.' }
      send_flash(Current.user, flash)
      format.html { render :index }
      format.js { render :error_update } # look into this later
    end
  end
end
