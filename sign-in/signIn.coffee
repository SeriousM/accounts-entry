Template.entrySignIn.helpers
  emailOnly: ->
    Accounts.ui._options.passwordSignupFields is 'EMAIL_ONLY'

  emailPlaceholder: ->
    fields = Accounts.ui._options.passwordSignupFields

    if _.contains([
      'USERNAME_AND_EMAIL'
      'USERNAME_AND_OPTIONAL_EMAIL'
      ], fields)
      return 'Username or email'

    return 'Email'

  logo: ->
    AccountsEntry.config.logo

Template.entrySignIn.events
  'submit #signIn': (event) ->
    event.preventDefault()
    Session.set('email', $('input[name="email"]').val())
    Session.set('password', $('input[name="password"]').val())

    Meteor.loginWithPassword(Session.get('email'), Session.get('password'), (error)->
      if error
        Session.set('error', error.reason)
      else
        Router.go('/')
    )
