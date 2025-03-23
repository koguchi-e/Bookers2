class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    case self.notifiable_type
    when "Book"
      "フォローしている#{self.notifiable.user.name}さんが#{self.notifiable.title}を投稿しました。"
    when "Favorite"
      "投稿した#{self.notifiable.book.title}が#{self.notifiable.user.name}さんにいいねされました。"
    when "Relationship"
      "#{self.notifiable.follower.name}さんにフォローされました。"
    end
  end
end
