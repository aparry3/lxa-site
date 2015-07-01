@OfficerUpdatesController = AppController.extend(
  sort:
    submitted: -1
    _id: -1
  type: 'officerPost'
  template: 'officerUpdates'
  nextPath: ->
    Router.routes.newPosts.path postsLimit: @postsLimit() + @increment
)
