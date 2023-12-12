# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController

  respond_to :json

  # ................Login.............................

  def user_login
    user = User.find_by(email: params[:user][:email])
    return render json: { error: "Please Check your Email....." } unless user.present? 
    return render json: { error: "Please enter valid password....." } unless user.valid_password?(params[:user][:password]) 
    code = rand(3 ** 10)
    user.update(code: code)
    type = params[:type]
    case type
    when 'email'  
      UserMailer.send_otp(user,code).deliver_later
    when 'mobile'
      Twilio::SmsService.new(user.contact_no, user.code).call
    else
      return render json: { error: 'Please give the correct type i.e., "email or mobile"' }
    end
    render json: { message: "Go to the next api to verify otp"}
  end

  private

  # ..................Verify Otp......................

  def respond_with(resource, _opts = {})
      return render json: { error: "Please Enter valid otp....." } unless params[:otp].to_i == current_user.code && current_user.present?  
      BuyTimeWorker.perform_async(current_user.attributes)
      render json: { message: "Logged in successfully" }
  end

  # ..................Logout user......................

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
