@Officers = new Mongo.Collection "officers"

Officers.helpers {}

Officers.before.insert (userId, doc) ->
  doc.createdAt = moment().toDate()

Officers.attachSchema new SimpleSchema
  name:
    type: String
    max: 200
  position:
    type: String
    max: 200
