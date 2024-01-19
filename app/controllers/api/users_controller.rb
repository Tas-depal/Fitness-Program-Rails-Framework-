# frozen_string_literal: true

# Api module
module Api
  # User Controller
  class UsersController < ApiController
    skip_before_action :authenticate_user!, only: %i[create user_login verify_otp home]

    # ..................Create User......................
    def create
      user = User.new(set_params)
      return render json: { message: 'User Created', data: user } if user.save
      token = jwt_encode(user_id: user.id)

      render json: { errors: user.errors.full_messages, token: token }
    end

    # ..................Login user......................
    def user_login
      @user = User.find_by(email: params[:user][:email], password_digest: params[:user][:password_digest])
      return render json: { error: 'Please Check your Email And Password.....' } unless @user.present?

      @otp = rand(3**10)
      @user.update(code: @otp)
      @type = params[:type]
      send_otp_mail
    end

    # .................Verify Otp........................
    def verify_otp
      user = User.find_by(email: params[:user][:email])
      return render json: { error: 'Please Check your email.....' } unless user.present?
      return render json: { error: 'Please Enter valid otp.....' } unless params[:otp].to_i == user.code

      token = jwt_encode(user_id: user.id)
      BuyTimeWorker.perform_async(user.attributes)
      render json: { message: 'Logged in successfully', token: token}
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


    def set_params
      params.require(:user).permit(:name, :email, :contact_no, :password_digest, :type)
    end

    def update_params
      params.require(:user).permit(:name, :email, :contact_no, :password_digest)
    end

    def send_otp_mail
      case @type
      when 'email'
        UserMailer.send_otp(@user, @otp).deliver_now
      when 'mobile'
        Twilio::SmsService.new(@user.contact_no, @user.code).call
      else
        return render json: { error: 'Please give the correct type i.e., "email or mobile"' }
      end
      render json: { message: 'Go to the next api to enter the otp' }
    end
  end
end
