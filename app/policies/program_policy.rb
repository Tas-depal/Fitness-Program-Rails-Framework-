class ProgramPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  attr_reader :user, :program

  def initialize(user, program)
    @user = user
    @program = program
  end

# .................Instructor Functionalities....................
  def index?
    user.Instructor? || !user.Customer?    
  end

  def create?
    user.Instructor? || !user.Customer?
  end

  def show?
    user.Instructor? || !user.Customer?
  end

  def update?
    user.Instructor? || !user.Customer?
  end

  def destroy?
    user.Instructor? || !user.Customer?
  end

  def search_program_name?
    user.Instructor? || !user.Customer?
  end

  def search_program_status?
    user.Instructor? || !user.Customer?
  end
  
  def delete_customer_purchase?
    user.Instructor? || !user.Customer?
  end

# .................Customer Functionalities....................
  def show_active_program?
    !user.Instructor? || user.Customer?
  end

  def show_category_wise_programs?
    !user.Instructor? || user.Customer?
  end

  def search_by_category_and_name?
    !user.Instructor? || user.Customer?
  end

  def search_in_customer_program?
    !user.Instructor? || user.Customer?
  end
end
