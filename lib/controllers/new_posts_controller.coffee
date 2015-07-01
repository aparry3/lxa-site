@NewPostsController = AppController.extend(
  sort:
    submitted: -1
    _id: -1
  nextPath: ->
    Router.routes.newPosts.path postsLimit: @postsLimit() + @increment
)
