Meteor.startup ->
  Factory.define "post", Posts,
    name: ->
      Fake.sentence()
    description: ->
      Fake.paragraph()
    rating: ->
      _.random 1, 5
  if Posts.find({}).count() == 0
    _(10).times (n) ->
      Factory.create "post"
