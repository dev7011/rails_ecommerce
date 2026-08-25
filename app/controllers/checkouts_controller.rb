class CheckoutsController < ApplicationController
  def create

    # das kann in config/initializers/stripe.rb konfiguriert werden, daher auskommentiert
    # Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    cart = params[:cart]

    line_items = cart.map do |item|
      product_id = item.dig("product", "id")
      stock_id = item["stockId"]
      quantity = item["quantity"]
      size = item["size"]

      product = Product.find(product_id)
      product_stock = product.stocks.find(stock_id)

      {
        quantity: quantity.to_i,
        price_data: {
          currency: "usd",
          unit_amount: product.price.to_i,
          product_data: {
            name: product.name,
            metadata: {
              product_id: product.id.to_s,
              size: size.to_s,
              product_stock_id: product_stock.id.to_s
            }
          }
        }
      }
    end

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: "#{root_url}/success",
      cancel_url: "#{root_url}/cancel",
      shipping_address_collection: {
        allowed_countries: %w[US CA]
      }
    )

    render json: { url: session.url, message: "Checkout created" }, status: :ok
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe error: #{e.message}")
    render json: { error: e.message }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def success; end

  def cancel; end

end