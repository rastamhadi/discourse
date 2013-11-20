class NotificationsController < ApplicationController

  before_filter :ensure_logged_in

  def index
    notifications = dropdown.notifications.to_a
    dropdown.mark_as_seen if notifications.present?
    current_user.reload
    current_user.publish_notifications_state

    render_serialized(notifications, NotificationSerializer)
  end

  private

  def dropdown
    @dropdown ||= NotificationsDropdown.new(current_user)
  end

end
