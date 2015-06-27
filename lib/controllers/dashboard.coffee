@DashboardController = AppController.extend
  waitOn: ->
    return @subscribe "posts"
  data:
    posts: Posts.find {}
  onAfterAction: ->
    Meta.setTitle "Dashboard"

DashboardController.events
  "click[date-action=doSomething]": (event, template) ->
    event.preventDefault();
