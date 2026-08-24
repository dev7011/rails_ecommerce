class ProductsController < ApplicationController
  before_action :set_admin_product, only: %i[ show buy_now ]
  def index
    @products = Product.order(:position, :id)
  end

  def buy_now
    @product = Product.find(params[:id])
  end

  def show; end

  private


  def set_admin_product
    @product = Product.find(params[:id])
  end
end
