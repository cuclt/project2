class Admin::CategoriesController < ApplicationController
  layout "admin_template"
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :load_category, only: [:destroy, :update, :edit]

  def index
    @categories = Category.newest.all
  end

  def destroy
    if @category.destroy
      flash[:success] = t "delete_successfully"
    else
      flash[:danger] = t "delete_not_successfully"
    end
    redirect_to admin_categories_path
  end

  def edit

  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "saved"
    else
      flash[:danger] = t "save_not_successfully"
    end
    redirect_to admin_categories_path
  end

  def update
    if params["_method"] == "patch"
      if @category.update_attributes category_params
        flash[:success] = t "saved"
      else
        render :edit
      end
    else
      if @category.update_attributes status: false
        flash[:success] = t "saved"
      end
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "category_not_exist"
      redirect_to admin_categories_path
    end
  end
end
