module Api	
	class PurchasesController < ApiController

	  before_action :authorize_user
	  before_action :find_id, only: [ :show, :update, :destroy ]

	# ..................Show purchased programs...............
	  def index
		  purchase = @current_user.purchases
		  if purchase.empty?
	      render json: { message: 'No data found...' }
		  else
		  	render json: purchase
			end
		end

	# ..................Purchase program.......................
		def create
			purchase=@current_user.purchases.new(set_params)
			program = Program.find_by(status: 'active' , id: purchase.program_id)
			if program
		    if purchase.save
					purchase.update(status: 'started')
		      render json: purchase, status: :ok
		    else
		      render json: { error: purchase.errors.full_messages }
		    end
		  else
		  	render json:{ message: 'Cannot add inactive program' }
		  end
		end

	# ..................Update Program Status.......................
		def update
			if @purchase.status == 'completed'
	      render json: { message: "Program is already completed.... " }
	    else
				@purchase.update(status: 'completed')
	      render json: { message: "Program has been marked as completed.... " }
	    end
		end

	# ..................Show Particular Purchased Program .......................
		def show
	    render json: @purchase
		end

	# ..................Delete Purchase .......................
		def destroy
			@purchase.destroy
	    render json: {message: "Purchase has been deleted.... "}
		end

		private
			def set_params
		    params.permit(:program_id)
		  end

	  	def find_id
				@purchase=@current_user.purchases.find_by_id(params[:id])
				unless @purchase
	        render json: "Id not found.." 
	      end   
	    end

	    def authorize_user
	      authorize Purchase
	    end

	end
end
