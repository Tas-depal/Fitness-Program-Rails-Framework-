class User < ApplicationRecord
	include Devise::JWT::RevocationStrategies::JTIMatcher
	
	devise :database_authenticatable, :registerable,
         :validatable, :omniauthable, :jwt_authenticatable, omniauth_providers: [:google_oauth2], jwt_revocation_strategy: self

  attr_accessor :skip_type

  has_many :programs, dependent: :destroy
	has_many :purchases, dependent: :destroy

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

  def self.from_omniauth(auth)

  	#..............Checks if the user is present or not...........

  	if where(provider: auth.provider, uid: auth.uid).first.present?
			user = User.find_by_email(auth.info.email)
  		user.skip_type = true
      code = rand(3 ** 10)
      user.update(code: code)
      UserMailer.send_otp(user,code).deliver_later

  	#.............Creates user if the user is not present...........

  	else
	    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  			user.skip_type = true
	      user.email = auth.info.email
	      user.password = Devise.friendly_token[0, 20]
	      user.name = auth.info.name # assuming the user model has a name
	      code = rand(3 ** 10)
	      user.update(code: code)
	      UserMailer.send_otp_oauth(user,code, user.password).deliver_later
	    end
  	end
  end
end

