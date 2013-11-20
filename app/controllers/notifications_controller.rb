class NotificationsController < ApplicationController

  before_filter :ensure_logged_in

  def index
    notifications = dropdown.latest_notifications

    if notifications.present?
      notifications += dropdown.latest_unread_private_messages
    end

    notifications = notifications.to_a
    current_user.saw_notification_id(notifications.first.id) if notifications.present?
    current_user.reload
    current_user.publish_notifications_state

    render_serialized(notifications, NotificationSerializer)
  end

  private

  def dropdown
    @dropdown ||= NotificationsDropdown.new(current_user)
  end

end
