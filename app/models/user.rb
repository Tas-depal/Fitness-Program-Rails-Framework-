class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

	has_many :programs, dependent: :destroy
	has_many :purchases, dependent: :destroy

	validates :name, :email, :contact_no, presence: true
	validates :type, presence: true, on: [ :create ]
	validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.[a-z]{2,3}\z/ } 
	validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
	validates :contact_no, uniqueness: true

	def Instructor?
		self.type=="Instructor"
	end
	def Customer?
		self.type=="Customer"
	end

end

