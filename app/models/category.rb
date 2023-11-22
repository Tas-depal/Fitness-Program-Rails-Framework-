class Category < ApplicationRecord
	has_many :programs, dependent: :destroy
		
	validates :category_name, presence:true, uniqueness: { case_sensitive: false }
	before_save :check_space

	def check_space
		self.category_name = category_name.strip()
	end 
end
