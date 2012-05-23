if Meteor.is_client
  Template.hello.greeting = ->
    "Welcome to meteor chat"

  Template.hello.events =
    'click input': (event) ->
      if (typeof console != 'undefined')
        console.log('hi')

