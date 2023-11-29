module Twilio
	class SmsService
		def initialize(to_phone_no, otp)
			@to_phone_no = to_phone_no
			@from_phone_no = '+13162517196'
			@otp = otp
		end

		def call
			@client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
			message = @client.messages
			.create(
				body: "\nHello\nThe Otp code is:\n#{@otp}",
				from: @from_phone_no,
				# The to phone number must be added in the verified caller ids in Twilio
				to: '@to_phone_no'
	        )
		end
	end
end