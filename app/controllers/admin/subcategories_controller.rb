# frozen_string_literal: true

module Admin
  # Controller for managing subcategories in the admin panel.
  class SubcategoriesController < ApplicationController
    before_action :set_category
    before_action :set_subcategory, only: %i[edit update destroy]

    def index
      @subcategories = @category.subcategories
      respond_to do |format|
        format.json { render json: @subcategories }
      end
    end

    def new
      @subcategory = @category.subcategories.build
      respond_to(&:js)
    end

    def create
      @subcategory = @category.subcategories.build(subcategory_params)

      respond_to do |format|
        if save_subcategory(format)
          format.js
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
          flash[:success] = 'Subcategory updated successfully.'
        else
          flash[:danger] = 'Failed to update subcategory.'
        end
        format.html { redirect_to admin_categories_path }
        format.js
      end
    end

    def destroy
      flash[:danger] = 'Subcategory was successfully destroyed.' if @subcategory.destroy
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
    def save_subcategory(format)
      if @subcategory.save
        flash[:success] = 'Successfully created subcategory.'
        format.html { redirect_to admin_category_path(@category) }
      else
        false
      end
    end

    # Handles failed subcategory creation.
    def handle_failed_subcategory_creation(format)
      flash[:danger] = 'Error creating subcategory.'
      format.js {}
    end
  end
end
