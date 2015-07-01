Template.homeHeader.rendered = ->
  $('.modal-trigger').leanModal()
  Meteor.setTimeout (->
    @$('.button-collapse').sideNav
      menuWidth: 240
      activationWidth: 70
      closeOnClick: true
    return
  ).bind(this), 200
  return
