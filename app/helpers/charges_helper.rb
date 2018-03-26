module ChargesHelper
  DEFAULT_CHARGE = 1500.freeze
  
  def self.charge_description(email)
    "BigMoney Membership - #{email}"
    # StripeChargesServices would not access this method without prefixing
    # method name with 'self.', regardless of call format. This maybe a very
    # insidious glitch, since an external test of the same calling structure
    # worked without 'self.' .
  end
  
  class StripeChargesServices
    DEFAULT_CURRENCY = 'usd'.freeze
    
    def initialize(params, user)
      @stripe_email = params[:stripeEmail]
      @stripe_token = params[:stripeToken]
      @user = user
    end

    def call
      create_charge(find_customer)
    end
    
    private

    attr_accessor :user, :stripe_email, :stripe_token
    
    def find_customer
      if user.stripe_token
        retrieve_customer(user.stripe_token)
      else
        create_customer
      end
    end

    def retrieve_customer(stripe_token)
      Stripe::Customer.retrieve(stripe_token) 
    end

    def create_customer
      customer = Stripe::Customer.create(
        email: stripe_email,
        source: stripe_token
      )
      user.update(stripe_token: customer.id)
      customer
    end

    def create_charge(customer)
      Stripe::Charge.create(
        customer: customer.id,
        amount: DEFAULT_CHARGE,
        description: ChargesHelper::charge_description(customer.email),
        currency: DEFAULT_CURRENCY
      )
    end
  end
end
