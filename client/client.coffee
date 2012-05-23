# Already in client dir, so no is_client is needed.
People = new Meteor.Collection('people')
Messages = new Meteor.Collection('messages')

Template.choose_username.username = ->
  Session.get('username')

Template.choose_username.events =
  'click #create-username': (event) ->
    event.preventDefault()
    username = $('#username').val()
    Session.set('username', username)

Template.hello.username = ->
  Session.get('username')


Template.hello.messages = ->
  Messages.find({})


Template.user_list.users = ->
  People.find({}, {sort: {name: 1}})


jQuery ->
  $('abbr.timeago').timeago()
