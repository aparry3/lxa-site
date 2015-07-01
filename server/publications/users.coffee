Meteor.publish 'singleUser', (userId) ->
  Meteor.users.find userId: @userId
