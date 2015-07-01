Meteor.publish 'notifications', ->
  Notifications.find
    userId: @userId
    read: false
