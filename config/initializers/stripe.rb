# Store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  publishable_key: Figaro.env.STRIPE_PUBLISHABLE_KEY,
  secret_key: Figaro.env.STRIPE_SECRET_KEY
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
