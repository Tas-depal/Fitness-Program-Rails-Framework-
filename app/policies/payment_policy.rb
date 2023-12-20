class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  attr_reader :user, :payment

  def initialize(user, payment)
    @user = user
    @payment = payment
  end

# .................Customer Functionalities....................

  def create?
    !user.Instructor? || user.Customer?
  end


end
