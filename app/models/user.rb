class User < ApplicationRecord
	require 'securerandom'

	has_many :programs, dependent: :destroy
	has_many :purchases, dependent: :destroy
	has_secure_password

	validates :name, :email, :contact_no, :password_digest, presence: true
	validates :type, presence: true, on: [ :create ]
	validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.[a-z]{2,3}\z/ } 
	validates :password_digest, length: { minimum: 8 }, format: { with: /\A\S+\z/ }
	validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
	validates :contact_no, length: { is: 10 }, uniqueness: true

def Instructor?
	self.type=="Instructor"
end
def Customer?
	self.type=="Customer"
end
end

