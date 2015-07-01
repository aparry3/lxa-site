Template.userPage.onCreated(function() {
  Session.set('editUserMode', false);
});

Template.userPage.onRendered(function () {
  this.find('.wrapper')._uihooks = {
    insertElement: function (node, next) {
      $(node)
        .hide()
        .insertBefore(next)
        .fadeIn();
    },
    moveElement: function (node, next) {
      var $node = $(node), $next = $(next);
     var oldTop = $node.offset().top;
     var height = $node.outerHeight(true);

     // find all the elements between next and node
     var $inBetween = $next.nextUntil(node);
     if ($inBetween.length === 0)
       $inBetween = $node.nextUntil(next);

     // now put node in place
     $node.insertBefore(next);

     // measure new top
     var newTop = $node.offset().top;

     // move node *back* to where it was before
     $node
       .removeClass('animate')
       .css('top', oldTop - newTop);

     // push every other element down (or up) to put them back
     $inBetween
       .removeClass('animate')
       .css('top', oldTop < newTop ? height : -1 * height)


     // force a redraw
     $node.offset();

     // reset everything to 0, animated
     $node.addClass('animate').css('top', 0);
     $inBetween.addClass('animate').css('top', 0);
   },
   removeElement: function(node) {
      $(node).fadeOut(function() {
        $(this).remove();
      });
  }
  }
});

Template.userPage.helpers({
  posts: function() {
    return Posts.find({userId: this._id});
  },
  overview: function() {
    if (!Session.get('editUserMode')) {
      return "active";
    }
  },
  edit: function() {
    if (Session.get('editUserMode')) {
      return "active";
    }
  },
  setEdit: function() {
    if (editUserMode) {
      editUserMode = false;
    } else {
      editUserMode = true;
    }
  },
  showEdit: function () {
    return Session.get('editUserMode');
  },
  showOverview: function() {
    return !Session.get('editUserMode');
  },
  fullName: function() {
    return this.profile.firstName + " " + this.profile.lastName;
  },
  email: function() {
    return this.emails[0].address;
  },
  ownProfile: function() {
    return this._id === Meteor.userId();
  }
});

Template.userPage.events({
  'click .showOverview': function(e) {
    e.preventDefault();
    if(Session.get('editUserMode')) {
      Session.set('editUserMode', false);
    }
  },
  'click .showEdit': function(e) {
    e.preventDefault();
    if(!Session.get('editUserMode')) {
      Session.set('editUserMode', true);
    }
  }
});
