# Already in client dir, so no is_client is needed.
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
      People.insert({name: username})

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
    $('abbr.timeago').timeago()

Template.user_list.total_users = ->
  People.find({}).fetch().length

Template.user_list.users = ->
  People.find({}, {sort: {name: 1}})


jQuery ->
  $('abbr.timeago').timeago()
