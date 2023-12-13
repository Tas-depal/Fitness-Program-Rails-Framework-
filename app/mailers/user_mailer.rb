class UserMailer < ApplicationMailer

  def welcome_mail(object)
    @object = object
    mail(to: @object['email'], subject: "Welcome #{object['name']}") 
  end

  def send_otp(object, otp)
    @object = object
    @otp = otp
    mail(to: @object.email, subject: "Welcome #{@object.name}") 
  end
  def send_otp_oauth(object, otp, password)
    @object = object
    @otp = otp
    @password = password
    mail(to: @object.email, subject: "Welcome #{@object.name}") 
  end
end
