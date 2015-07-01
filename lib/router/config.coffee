Router.configure
  layoutTemplate: 'homeLayout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: ->
    [ Meteor.subscribe('notifications') ]

Router.plugin "dataNotFound",
  dataNotFoundTemplate: "notFound"
