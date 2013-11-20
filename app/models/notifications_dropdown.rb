class NotificationsDropdown

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def mark_as_seen
    User.where(["id = ? and seen_notification_id < ?", user, top_notification])
        .update_all ["seen_notification_id = ?", top_notification]
  end

  def notifications
    @notifications ||= latest_notifications + latest_unread_private_messages
  end

  private

  def top_notification
    @top_notification ||= notifications.first
  end

  def latest_unread_private_messages
    if latest_notifications.present?
      user.notifications.latest(5).unread.private_messages
        .where('id < ?', latest_notifications.last)
    else
      []
    end
  end

  def latest_notifications
    @latest_notifications ||= user.notifications.latest(10).includes(:topic)
  end

end