class NotificationsDropdown

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def latest_unread_private_messages
    user.notifications.latest(5).unread.private_messages
      .where('id < ?', latest_notifications.last)
  end

  def latest_notifications
    @latest_notifications ||= user.notifications.latest(10).includes(:topic)
  end

end