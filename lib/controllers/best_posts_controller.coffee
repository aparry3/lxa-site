@BestPostsController = AppController.extend(
  sort:
    votes: -1
    submitted: -1
    _id: -1
  nextPath: ->
    Router.routes.bestPosts.path postsLimit: @postsLimit() + @increment
)
