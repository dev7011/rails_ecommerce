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
    @admin_order = Order.new(admin_order_params)

    if @admin_order.save
      redirect_to admin_order_path(@admin_order),
                  notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @admin_order.update(admin_order_params)
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
    params.require(:order).permit!
  end
end