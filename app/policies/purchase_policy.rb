class PurchasePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  attr_reader :user, :purchase

  def initialize(user, purchase)
    @user = user
    @purchase = purchase
  end

  def index?
    user.Customer? || !user.Instructor?
  end

  def create?
    user.Customer? || !user.Instructor?
  end

  def update?
    user.Customer? || !user.Instructor?
  end

  def show?
    user.Customer? || !user.Instructor?
  end

  def destroy?
    user.Customer? || !user.Instructor?
  end
end
