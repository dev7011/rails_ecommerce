class Admin::OrdersController < AdminController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @admin_orders = Order.all
  end

  def show
  end

  def new
    @admin_order = Order.new
  end

  def edit
  end

  def create
    @admin_order = Order.new(order_params)

    # subtotal und total_amount berechnen
    @admin_order.order_items.each do |item|
      item.unit_price = item.product.price
      item.subtotal = item.quantity * item.unit_price
    end

    @admin_order.total_amount = @admin_order.order_items.sum(&:subtotal)

    if @order.save
      redirect_to admin_order_path(@admin_order), notice: "Bestellung wurde erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @admin_order.assign_attributes(admin_order_params)

    if @admin_order.save
      redirect_to admin_order_path(@admin_order),
        notice: "Order was successfully updated.",
        status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @admin_order.destroy!

    redirect_to admin_orders_path,
      notice: "Order was successfully destroyed.",
      status: :see_other
  end

  private

  def set_order
    @admin_order = Order.find(params[:id])
  end

  def admin_order_params
    params.require(:order).permit(
      :address,
      :customer_email,
      order_items_attributes: %i[
        quantity
        product_id
        unit_price
        subtotal
      ])
  end
end