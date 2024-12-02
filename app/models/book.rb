class Book < ApplicationRecord
  validates :title, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :body, presence: true, length: { maximum: 200 }
  belongs_to :user
end
