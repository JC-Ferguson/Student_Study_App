class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
    end

    def webhook
        payment_id = params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        user_id = payment.metadata.user_id
        User.find(user_id.to_i).tutor.update(payment_id:payment_id)
    end
end