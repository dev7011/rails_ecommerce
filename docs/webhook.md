♦️ webhooks_controller.rb
https://docs.stripe.com/

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token 
  
  def stripe
  end
end

   

# connection im Local => bash  

    brew install stripe/stripe-cli/stripe
    stripe listen --forward-to localhost:3000/webhooks

      👉 Your webhook signing secret is whsec_1316a3d448941aa43cf36a6a9d5ec51a7e462c72c61306db92e11ac3fd (^C to quit)
      ♦️ Dies muss in EDITOR=nano rails credentials:edit gespeichert werden
          stripe:   
              webhook_secret: whsec_1316a3d448941aa43cf36a6a9d5ec51a7e462c72c61306db92e11ac3fd


♦️ Testen deines Stripe-Webhooks
  # bash
  stripe listen --forward-to localhost:3000/webhooks