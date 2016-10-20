class ProductsController < ApplicationController
  def index
    @products = Product.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end
end