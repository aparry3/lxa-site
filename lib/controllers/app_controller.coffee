@AppController = RouteController.extend(
  layoutTemplate: 'appLayout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  increment: 10
  postsLimit: ->
    parseInt(@params.postsLimit) or @increment
  findOptions: ->
    {
      sort: @sort
      limit: @postsLimit()
    }
  findType: ->
    { type: @type }
  subscriptions: ->
    @postsSub = Meteor.subscribe('posts', @findOptions())
    return
  posts: ->
    Posts.find @findType(), @findOptions()
  data: ->
    hasMore = @posts().count() == @postsLimit()
    {
      posts: @posts()
      ready: @postsSub.ready
      nextPath: if hasMore then @nextPath() else null
    }
)
