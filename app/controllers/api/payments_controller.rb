module Api
	class PaymentsController < ApiController

		before_action :authorize_user

		def create
			@purchase = current_user.purchases.find_by_id(params[:purchase_id])
			return render json: { error: "Please enter valid purchase id"} unless @purchase
			create_on_stripe
			payment = Payment.create(purchase_id: params[:purchase_id], stripe_id: @response.id)
			render json: {data: @response, success: 'Payment done successfully'}
		end

		private

    def create_on_stripe
    	params_stripe = { amount: @purchase.amount, currency: params[:currency], customer: current_user.stripe_id, automatic_payment_methods: { enabled: true, allow_redirects: 'never' }, shipping: { address: { city: params[:city], country: params[:country], line1: params[:address], postal_code: params[:postal_code] }, name: params[:shipping_name] }, confirm: true, payment_method: 'pm_card_visa', description: 'success' }
	    @response = Stripe::PaymentIntent.create(params_stripe)
    end
    
		def authorize_user
      authorize Payment
    end
	end
end