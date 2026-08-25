class WebhooksController < ApplicationController
  skip_forgery_protection

  # es dient dazu, dass Stripe Webhooks an diese Route senden kann, ohne dass ein CSRF-Token erforderlich ist.

  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    Rails.logger.error("Webhook signature header missing: #{payload}")

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error("Stripe signature verification failed: #{e.message}")
      return head :bad_request
    end

    # Address from stripe
    case event.type
    when "checkout.session.completed"
      # Hier können Sie die Logik implementieren, die ausgeführt werden soll,
      # wenn eine Checkout-Session abgeschlossen ist.
      session = event.data.object
      address_details = session["shipping"]["address"]

      address = if address_details
                  [
                    address_details.line1,
                    address_details.line2,
                    address_details.city,
                    address_details.state,
                    address_details.postal_code,
                    address_details.country
                  ].compact.join(", ")
                else
                  ""
                end

      order = Order.create!(
        customer_email: session["customer_details"]["email"],
        total_amount: session[:amount_total],
        fulfilled: false,
        address: address
      )

      full_session = Stripe::Checkout::Session.retrieve(
        id: session.id,
        expand: ["line_items"]
      )

      line_items = full_session.line_items

      line_items["data"].each do |line_item|
        product = Stripe::Product.retrieve(line_item["price"]["product"])
        next unless product

        metadata = product["metadata"]

        OrderItem.create!(
          order: order,
          product_id: metadata.product_id.to_i,
          quantity: line_item.quantity,
          size: metadata.size,
          unit_price: line_item.price.unit_amount,
          subtotal: line_item.quantity * line_item.price.unit_amount
        )

        Stock.find(metadata.product_stock_id).decrement!(:amount, line_item.quantity)
      end

    else
      Rails.logger.info("Unhandled event type: #{event.type}")
    end

    render json: { message: "webhook success" }, status: :ok
  end
end
