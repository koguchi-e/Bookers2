class Book < ApplicationRecord
  validates :title, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :body, presence: true, length: { maximum: 200 }
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  def favaritede_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
