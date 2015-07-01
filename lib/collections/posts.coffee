@Posts = new (Mongo.Collection)('posts')

#
# PERMISSIONS
#

Posts.allow
  update: (userId, post) ->
    ownsDocument userId, post
  remove: (userId, post) ->
    ownsDocument userId, post
Posts.deny update: (userId, post, fieldNames) ->
  #may only edit these three fields
  _.without(fieldNames, 'url', 'title', 'content').length > 0
Posts.deny update: (userId, post, fieldNames, modifier) ->
  errors = validatePost(modifier.$set)
  errors.content

#
# METHODS
#

Meteor.methods
  postInsert: (postAttributes) ->
    check Meteor.userId(), String
    #Find out way to check for field type without necessarily being complete
    # check(postAttributes , {
    #   content: String,
    #   url: String
    # });
    errors = validatePost(postAttributes)
    if errors.title or errors.url or errors.content
      throw new (Meteor.Error)('invalid-post', 'You must have content in your post')
    user = Meteor.user()
    console.log user
    post = _.extend(postAttributes,
      userId: user._id
      author: user.profile.firstName + ' ' + user.profile.lastName
      submitted: new Date
      commentsCount: 0
      upvoters: []
      votes: 0)
    postId = Posts.insert(post)
    { _id: postId }
  upvote: (postId) ->
    check @userId, String
    check postId, String
    affected = Posts.update({
      _id: postId
      upvoters: $ne: @userId
    },
      $addToSet: upvoters: @userId
      $inc: votes: 1)
    if !affected
      throw new (Meteor.Error)('invalid', 'You weren\'t able to update that post')
    return

#
# HELPERS
#

validatePost = (post) ->
  errors = {}
  if !post.content
    errors.content = 'Please add content to your post'
  errors
