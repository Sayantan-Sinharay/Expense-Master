class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  layout "user"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:name])
    respond_to do |format|
      if @category.save
        flash[:success] = "Category was successfully created."
        format.html { redirect_to admin_categories_path }
        format.js
      else
        flash[:danger] = "Category could not be created."
        format.html { redirect_to admin_categories_path }
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:success] = "Category updated successfully."
      else
        flash[:danger] = "Failed to update category."
      end
      format.html { redirect_to admin_categories_path }
      format.js
    end
  end

  def destroy
    if @category.destroy
      flash[:danger] = "Category was successfully destroyed."
    end
    respond_to do |format|
      format.html { redirect_to admin_categories_path }
      format.js
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
