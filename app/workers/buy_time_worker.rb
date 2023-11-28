class BuyTimeWorker
	include Sidekiq::Worker
	def perform(user)
		UserMailer.welcome_mail(user).deliver_later
	end
end