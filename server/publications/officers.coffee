Meteor.publishComposite "officers", ->
  find: ->
    Officers.find {}
