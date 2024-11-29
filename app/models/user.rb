class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  self.authentication_keys = [:name]

  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'default_profile_image.png' # デフォルト画像を指定
    end
  end

end
