Template.postItem.helpers
  ownPost: ->
    @userId == Meteor.userId()
  domain: ->
    a = document.createElement('a')
    a.href = @url
    a.hostname
  upvotedClass: ->
    userId = Meteor.userId()
    if userId and !_.include(@upvoters, userId)
      'btn- primary upvotable'
    else
      'disabled'
Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id
    return
  'click #post-view-author': (event) ->
    Router.go '/users' + '/' + @userId
    return
  'click .delete': (e) ->
    e.preventDefault()
    if confirm('Delete this post?')
      currentPostId = @_id
      Posts.remove currentPostId
    return
