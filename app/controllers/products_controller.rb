class ProductsController < ApplicationController
  before_action :set_admin_product, only: %i[ show ]
  def index
    @admin_products = Product.order(:position, :id)
  end

  def show; end

  private


  def set_admin_product
    @admin_product = Product.find(params[:id])
  end
end
