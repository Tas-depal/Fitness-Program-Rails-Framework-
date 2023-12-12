class ApplicationController < ActionController::Base
	# .............Active storage Url.................
	before_action do
	    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
	end
	protect_from_forgery

	include Pundit::Authorization	
	
	# ................Authentication request............
		before_action :authenticate_user!

	# ................Authorize user............
	  around_action :pundit_authorization

	# ...............Handle user authorization
		def pundit_authorization
			yield
			rescue Pundit::NotAuthorizedError
				render json: { error: "You are not allowed to access this api..." }
		end
end

