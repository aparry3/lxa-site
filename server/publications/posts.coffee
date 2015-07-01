Meteor.publish 'posts', (options) ->
  check options,
    sort: Object
    limit: Number
  Posts.find {}, options

Meteor.publish 'singlePost', (id) ->
  check id, String
  Posts.find id

Meteor.publish 'userPosts', (id) ->
  Posts.find userId: id
