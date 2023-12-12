# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :type, :contact_no, :password])
  end

  private
  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
        status: {code: 200, message: "Signed up successfully."},
        data: resource
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        status: { code: 200, message: "Account deleted successfully."}
      }, status: :ok
    elsif request.method == "PUT" || request.method == "PATCH"
      if resource.update(resource_params)
        render json: {
          status: { code: 200, message: "Resource updated successfully." },
          data: resource
        }, status: :ok
      else
        render json: {
          status: { code: 422, message: "Resource couldn't be updated successfully. #{resource.errors.full_messages.to_sentence}" }
        }, status: :unprocessable_entity
      end
    else
      render json: {
        status: {code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def resource_params
    # Define strong parameters for resource update
    params.require(:user).permit(:name, :email, :contact_no)
  end
end
