class ChargesController < ApplicationController
  include ChargesHelper
  rescue_from Stripe::CardError, with: :catch_exception
 
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: ChargesHelper::charge_description(current_user.email),
      amount: DEFAULT_CHARGE
    }
  end
 
  def create
    StripeChargesServices.new(charges_params, current_user).call
    current_user.update!(role: :premium)
    p "hello"
    flash[:notice] = "Thanks for all the money, #{current_user.email}! " +
      "Feel free to pay me again."
    redirect_to root_path
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
