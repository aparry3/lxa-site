Meteor.publishComposite "posts", ->
  find: -> 
    Posts.find {}
