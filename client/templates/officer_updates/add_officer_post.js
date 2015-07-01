Template.addOfficerPost.onCreated(function() {
  Session.set('postSubmitErrors', {});
  Session.set('showUrlForm', false);
});

Template.addOfficerPost.helpers({
  errorMessage: function(field) {
    return Session.get('postSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('postSubmitErrors')[field] ? 'has-error' : '';
  },
  showUrl: function () {
    return Session.get('showUrlForm');
  }
});

Template.addOfficerPost.events({
  'submit form': function(e) {
    e.preventDefault();

    var post = {
      subject: $(e.target).find('[name=subject]').val(),
      content: $(e.target).find('[name=content]').val(),
      url: $(e.target).find('[name=url]').val(),
      type: "officerPost"
    };

    var errors = validatePost(post);
    if (errors.content)
      return Session.set('postSubmitErrors', errors);

    Meteor.call('postInsert', post, function(error, result) {
      if (error)
        return throwError(error.reason);
    });
  },

  'click .showUrl': function(e) {
    e.preventDefault();
    if(Session.get('showUrlForm')) {
      Session.set('showUrlForm', false);
    } else {
      Session.set('showUrlForm', true);
    }
  }
});
