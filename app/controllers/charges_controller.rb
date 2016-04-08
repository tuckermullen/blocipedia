class ChargesController < ApplicationController

  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attributes!(role: 'premium')

    flash[:notice] = "Thank you for upgrading to a Premium Membership, #{current_user.email}!"
    redirect_to root_path # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This 'rescue block' catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    if user_signed_in?
      @amount = 15_00
      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "BigMoney Membership - #{current_user.email}",
        amount: @amount
      }
    else
      redirect_to root_path
      flash[:notice] = "You must be signed in to do that."
    end
  end
end
