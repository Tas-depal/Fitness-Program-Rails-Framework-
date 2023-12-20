class Purchase < ApplicationRecord
  belongs_to :user

  belongs_to :program

  validates :program_id, presence: true, uniqueness: {scope: :user_id}

  has_one :payment, dependent: :destroy

end
