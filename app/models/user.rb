class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  self.authentication_keys = [:name]

  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy

  # 通知機能
  has_many :notifications, dependent: :destroy

  ##########################################################

  # フォローする側
  # 中間テーブルへ
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 中間テーブルを通して、フォローされる側テーブルへ
  has_many :followings, through: :relationships, source: :followed

  # フォローされる側
  # 中間テーブルへ
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 中間テーブルを通して、フォローする側テーブルへ
  has_many :followers, through: :reverse_of_relationships, source: :follower

  ##########################################################

  validates :name, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'default_profile_image.png'
    end
  end

  ##########################################################

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
