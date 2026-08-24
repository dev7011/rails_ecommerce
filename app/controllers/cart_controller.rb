class CartController < ApplicationController
  def cart_list
  end

  def checkout
    puts "Checkout params: #{params.inspect}"
    redirect_to products_path
  end
end
