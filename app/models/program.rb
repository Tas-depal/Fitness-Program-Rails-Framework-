class Program < ApplicationRecord
	has_many :purchases, dependent: :destroy
	belongs_to :user
	belongs_to :category
	has_one_attached :video, dependent: :destroy

	validates :name, :status, :price, :video, presence: true
	validates :status, inclusion: { in: %w(active inactive) }
	validates :name, uniqueness: { scope: :user_id, case_sensitive: false  }
	before_save :check_space

	def check_space
		self.name = name.strip()
	end 
end
