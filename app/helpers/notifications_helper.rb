module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Book"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました。"
    end
  end
end
