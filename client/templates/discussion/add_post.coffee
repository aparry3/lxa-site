Template.addPost.onCreated ->
  Session.set 'postSubmitErrors', {}
  Session.set 'showUrlForm', false
  return

Template.addPost.helpers
  errorMessage: (field) ->
    Session.get('postSubmitErrors')[field]
  errorClass: (field) ->
    if ! !Session.get('postSubmitErrors')[field] then 'has-error' else ''
  showUrl: ->
    Session.get 'showUrlForm'

Template.addPost.events
  'click .submit': (e) ->
    e.preventDefault()
    post =
      content: $(e.target).find('[name=content]').val()
      url: $(e.target).find('[name=url]').val()
    errors = validatePost(post)
    console.log errors
    if errors.content
      return Session.set('postSubmitErrors', errors)
    Meteor.call 'postInsert', post, (error, result) ->
      if error
        return throwError(error.reason)
      return
    return
  'click .showUrl': (e) ->
    e.preventDefault()
    if Session.get('showUrlForm')
      Session.set 'showUrlForm', false
    else
      Session.set 'showUrlForm', true
    return

  validatePost = (post) ->
    errors = {}
    if !post.content
      errors.content = 'Please add content to your post'
    errors
