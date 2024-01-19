# frozen_string_literal: true

# Api module
module Api
  # Omniauth controller
  class OmniauthController < ApplicationController

    # .................Google Omniauth.................
    def google_oauth2
      @user = find_user
      if @user.present?
        update_code
        UserMailer.send_otp(@user, @code).deliver_now
      else
        @user = create_user
        update_code
        UserMailer.send_otp_oauth(@user, @code, @user.password_digest).deliver_now
      end
      render json: { message: 'User logged in successfully' }
    end

    private

    def find_user
      User.find_by(uid: request.env['omniauth.auth']['uid'],
                   provider: request.env['omniauth.auth']['provider'])
    end

    def create_user
      user_params = {
        uid: request.env['omniauth.auth']['uid'],
        provider: request.env['omniauth.auth']['provider'],
        name: request.env['omniauth.auth']['info']['name'],
        email: request.env['omniauth.auth']['info']['email'],
        password_digest: SecureRandom.hex(10)
      }
      User.create(user_params)
    end

    def update_code
      session[:user_id] = @user.id
      @user.skip_type = true
      @code = rand(3**10)
      @user.update(code: @code)
    end
  end
end
