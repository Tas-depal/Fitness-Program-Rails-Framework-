module Api
	class ApiController < ActionController::API

		include JsonWebToken
		include Pundit::Authorization	
		
	# .............Active storage Url.................
		before_action do
	    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
	  end
	# ................Authentication request............
		before_action :authenticate_request

	# ................Authorize user............
	  around_action :pundit_authorization

	# ...................Authenticate User..................
		def authenticate_request
			begin
			  header = request.headers[ 'Authorization' ]
			  header = header.split(" ").last if header
			  decoded = jwt_decode(header)
			  @current_user = User.find(decoded[:user_id])
			rescue JWT::DecodeError => e
				render json: { error: 'Invalid token' }, status: :unprocessable_entity
			end
			rescue ActiveRecord::RecordNotFound
	    	render json: "No record found.."
		end

	# ..............Check user.....................
		def current_user
			@current_user
		end 

	# ...............Handle user authorization
		def pundit_authorization
			yield
			rescue Pundit::NotAuthorizedError
				render json: { error: "You are not allowed to access this api..." }
		end
	end
end
