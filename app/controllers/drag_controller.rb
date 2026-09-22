class DragController < ApplicationController
  def project
    @project = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:position)
  end
end

