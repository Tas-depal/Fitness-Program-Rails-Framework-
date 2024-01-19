class User < ApplicationRecord
	require 'securerandom'

  attr_accessor :skip_type

  has_many :programs, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_secure_password

	validates :name, :email, presence: true
	validates :type, presence: true, on: [ :create ], unless: :skip_type
	validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.[a-z]{2,3}\z/ } 
	validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
	validates :contact_no, uniqueness: true
	validates :stripe_id, presence: true, if: :Customer?

  before_validation :create_on_stripe, on: :create, if: :Customer?

  # ...........Saving stripe id in user model....................
  def create_on_stripe
    params = { email: email, name: name }
    response = Stripe::Customer.create(params)
    self.stripe_id = response.id
  end

	def Instructor?
		self.type=="Instructor"
	end

	def Customer?
		self.type=="Customer"
	end

end

