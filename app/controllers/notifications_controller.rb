class NotificationsController < ApplicationController

  before_filter :ensure_logged_in

  def index
    dropdown.mark_as_seen
    current_user.reload
    current_user.publish_notifications_state

    render_serialized(dropdown.notifications, NotificationSerializer)
  end

  private

  def dropdown
    @dropdown ||= NotificationsDropdown.new(current_user)
  end

end
