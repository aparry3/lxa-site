Meteor.publish 'comments', (postId) ->
  check postId, String
  Comments.find postId: postId
