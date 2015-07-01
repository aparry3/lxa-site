Router.route "/",
  name: "home"

Router.route '/new/:postsLimit?',
  name: 'newPosts'
  template: 'postsList'

Router.route '/best/:postsLimit?',
  name: 'bestPosts'
  template: 'postsList'

Router.route '/posts/:_id',
  name: 'postPage'
  layoutTemplate: 'appLayout'
  waitOn: ->
    [
      Meteor.subscribe('singlePost', @params._id)
      Meteor.subscribe('comments', @params._id)
    ]
  data: ->
    Posts.findOne @params._id

Router.route '/posts/:_id/edit',
  name: 'postEdit'
  layoutTemplate: 'appLayout'
  waitOn: ->
    Meteor.subscribe 'singlePost', @params._id
  data: ->
    Posts.findOne @params._id

Router.route '/users/:_id',
  name: 'userPage'
  layoutTemplate: 'appLayout'
  waitOn: ->
    [
      Meteor.subscribe('singleUser', @params._id)
      Meteor.subscribe('userPosts', @params._id)
    ]
  data: ->
    Meteor.users.findOne @params._id

Router.route '/discussion',
  name: 'discussion'
  template: 'postsList'
  controller: NewPostsController

Router.route '/officerUpdates', name: 'officerUpdates'

Router.route '/submit', name: 'postSubmit'

Router.plugin 'ensureSignedIn', only: [ 'dashboard' ]
