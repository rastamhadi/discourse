require 'spec_helper'

describe NotificationsDropdown do

  describe 'mark_as_seen' do
    it 'correctly updates the read state' do
      user = Fabricate(:user)

      pm = Notification.create!(read: false,
                           user_id: user.id,
                           topic_id: 2,
                           post_number: 1,
                           data: '[]',
                           notification_type: Notification.types[:private_message])

      other = Notification.create!(read: false,
                           user_id: user.id,
                           topic_id: 2,
                           post_number: 1,
                           data: '[]',
                           notification_type: Notification.types[:mentioned])

      dropdown = NotificationsDropdown.new(user)


      dropdown.mark_as_seen
      user.reload

      user.unread_notifications.should == 0
      user.unread_private_messages.should == 1
    end
  end

end