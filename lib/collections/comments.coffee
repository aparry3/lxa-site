@Comments = new Mongo.Collection 'comments'

#
# PERMISSIONS
#

#
# METHODS
#

Meteor.methods commentInsert: (commentAttributes) ->
  check @userId, String
  check commentAttributes,
    postId: String
    body: String
  user = Meteor.user()
  post = Posts.findOne(commentAttributes.postId)
  if !post
    throw new (Meteor.Error)('invalid-comment', 'You must comment on a post')
  comment = _.extend(commentAttributes,
    userId: user._id
    author: user.profile.firstName + ' ' + user.profile.lastName
    submitted: new Date)
  Posts.update comment.postId, $inc: commentsCount: 1
  comment._id = Comments.insert(comment)
  createCommentNotification comment
  comment._id

#
# HELPERS
#
