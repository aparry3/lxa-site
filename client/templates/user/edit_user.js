Template.editUser.onCreated(function() {
  Session.set('postSubmitErrors', {});
});

Template.editUser.helpers({
  errorMessage: function(field) {
    return Session.get('postSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('postSubmitErrors')[field] ? 'has-error' : '';
  },
  email: function() {
    return this.emails[0].address;
  },
  fullName: function() {
    return this.profile.firstName + " " + this.profile.lastName;
  }
});
