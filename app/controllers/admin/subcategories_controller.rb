# frozen_string_literal: true

module Admin
  # Controller for managing subcategories in the admin panel.
  class SubcategoriesController < ApplicationController
    before_action :authenticate_admin, except: :index
    before_action :set_category
    before_action :set_subcategory, only: %i[edit update destroy]

    include NotificationsHelper

    def index
      @subcategories = @category.subcategories.all
      respond_to do |format|
        format.html { render @subcategories }
        format.json { render json: @subcategories }
      end
    end

    def new
      @subcategory = @category.subcategories.build
      respond_to(&:js)
    end

    def create
      @subcategory = @category.subcategories.new(subcategory_params)

      respond_to do |format|
        if @subcategory.valid?
          handle_successful_subcategory_creation(format)
        else
          handle_failed_subcategory_creation(format)
        end
      end
    end

    def edit
      respond_to(&:js)
    end

    def update
      respond_to do |format|
        if @subcategory.update(subcategory_params)
          handle_valid_update(format)
        else
          handle_invalid_update(format)
        end
      end
    end

    def destroy
      flash = { danger: 'Subcategory has been deleted' }
      send_flash(Current.user, flash) if @subcategory.destroy
      respond_to(&:js)
    end

    private

    # Finds and sets the category based on the category_id parameter.
    def set_category
      @category = Category.find(params[:category_id])
    end

    # Finds and sets the subcategory based on the ID parameter.
    def set_subcategory
      @subcategory = @category.subcategories.find(params[:id])
    end

    # Permits the subcategory parameters.
    def subcategory_params
      params.require(:subcategory).permit(:name)
    end

    # Saves the subcategory and handles success.
    def handle_successful_subcategory_creation(format)
      @subcategory.save
      flash = { success: 'Successfully created subcategory.' }
      send_flash(Current.user, flash)
      format.html { redirect_to admin_categories_path }
      format.js {}
    end

    # Handles failed subcategory creation.
    def handle_failed_subcategory_creation(format)
      format.html { redirect_to admin_categories_path }
      format.js { render :error_create } # look into this later
    end

    def handle_valid_update(format)
      flash = { success: 'Successfully updated subcategory.' }
      send_flash(Current.user, flash)
      format.html { redirect_to admin_categories_path }
      format.js {}
    end

    def handle_invalid_update(format)
      format.html { redirect_to admin_categories_path }
      format.js { render :error_create } # look into this later
    end
  end
end
