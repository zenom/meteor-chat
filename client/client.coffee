Template.choose_username.username = ->
  Session.get('username')

Template.choose_username.events =
  'click #create-username': (event) ->
    event.preventDefault()
    username = $('#username').val()
    found = People.findOne({name: username})
    if found
      $('#username_exists').show();
    else
      Session.set('username', username)
      now = new Date().getTime()
      People.insert({name: username, idle: false, last_keepalive: now})

Template.hello.username = ->
  Session.get('username')


Template.hello.messages = ->
  Messages.find({}, {sort: {timestamp: -1}})

Template.hello.events =
  'click #send-message': (event) ->
    event.preventDefault()
    message = $('#chat-message').val()
    timestamp = new Date
    Messages.insert({user: Session.get('username'), timestamp: timestamp, message: message})
    $('#chat-message').val('')

Template.user_list.total_users = ->
  People.find({}).fetch().length

Template.user_list.users = ->
  People.find({}, {sort: {name: 1}})

# Needs some work #
update_idle = ->
  now = new Date().getTime()
  idle_threshold = now - 70 * 1000
  remove_threshold = now * 30 * 30 * 1000
  People.update({$lt: { last_keepalive: idle_threshold}}, {$set: {idle: true}})

# update the idle status
Meteor.setInterval update_idle, 30000

jQuery ->
  $('abbr.timeago').timeago()
