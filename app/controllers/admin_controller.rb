class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def dashboard
    @orders = Order.all.where(fulfilled: false).order(:created_at)

    @orders_today = @orders.where(created_at: Time.zone.now.midnight..Time.zone.now.end_of_day)

    @orders_by_day = @orders.where("created_at: > from_date", from_date: Time.zone.now - 7.days )

    @quick_stats = {
      sales: @orders_today.count || 0,
      revenue: @orders_today.sum(:total_amount) || 0,
      avg_sale: @orders_today.average(:total_amount) || 0,
    }
  end
end
