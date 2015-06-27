Meteor.startup ->
  Factory.define "officer", Officers,
    name: ->
      Fake.word()
    position: ->
      Fake.word()
  if Officers.find({}).count() == 0
    _(14).times (n) ->
      Factory.create "officer"
