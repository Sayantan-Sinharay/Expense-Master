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
        if @subcategory.save
          flash[:success] = 'Successfully created subcategory.'
          format.html { redirect_to admin_category_path(@category) }
          format.js
        else
          flash[:danger] = 'Error creating subcategory.'
          format.js {}
        end
      end
    end

    def edit
      respond_to(&:js)
    end

    def update
      respond_to do |format|
        if @subcategory.update(subcategory_params)
          flash[:success] = 'Category updated successfully.'
        else
          flash[:danger] = 'Failed to update category.'
        end
        format.html { redirect_to admin_categories_path }
        format.js
      end
    end

    def destroy
      flash[:danger] = 'Category was successfully destroyed.' if @subcategory.destroy
      respond_to(&:js)
    end

    private

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_subcategory
      @subcategory = @category.subcategories.find(params[:id])
    end

    def subcategory_params
      params.require(:subcategory).permit(:name)
    end
  end
end
