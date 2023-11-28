class UsersController < ApiController

  skip_before_action :authenticate_request, only: [:create, :user_login, :verify_otp]

# ..................Create instructor......................
  def create
    user = User.new(set_params)
    return render json: { message:"User Created", data: user } if user.save
    render json: { errors: user.errors.full_messages }
  end

# ..................Login user......................
  def user_login
    user = User.find_by(email: params[:email], password_digest: params[:password_digest])
    return render json: { error: "Please Check your Email And Password....." } unless user.present?     
    otp = rand(3 ** 10)
    user.update(otp: otp)
    UserMailer.send_otp(user,otp).deliver_later
    render json: { message: "Please enter the otp"}
  end

# .................Verify Otp........................
  def verify_otp
    user = User.find_by(email: params[:email])
    return render json: { error: "Please Enter valid otp....." } unless params[:otp].to_i == user.otp && user.present?  
    token = jwt_encode(user_id: user.id)    
    BuyTimeWorker.perform_async(user.attributes)
    render json: { message: "Logged in successfully", token: token }
  end
  
# ..................Update user......................
  def update
    user = User.find_by_id(@current_user.id)    
    return render json: { message: 'Updated successfully......', data: user } if user.update(update_params)
    render json: { errors: user.errors.full_messages }      
  end

# ..................Destroy user......................
  def destroy
    user = User.destroy(@current_user.id)
    render json: { message: 'Deleted successfully', data: user }
  end

# ..................Show user......................
  def show
    render json: @current_user
  end

  private 
    def set_params
      params.permit(:name,:email,:contact_no,:password_digest,:type)
    end

    def update_params
      params.permit(:name,:email,:contact_no,:password_digest)
    end
end
