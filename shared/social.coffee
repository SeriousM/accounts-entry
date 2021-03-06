Template.entrySocial.helpers
  buttonText: ->
    Session.get('buttonText')

  google: ->
    if @[0] == 'g'
      true

Template.entrySocial.events
  'click .btn': ->
    serviceName = $(event.target).attr('id').split('-')[1]
    callback = (err) ->
      if (!err)
        Router.go('dashboard')
      else if (err instanceof Accounts.LoginCancelledError)
        # do nothing
      else if (err instanceof ServiceConfiguration.ConfigError)
        # FIX THIS
        loginButtonsSession.configureService(serviceName)
      else
        # FIX THIS
        loginButtonsSession.errorMessage(err.reason || "Unknown error")
    loginWithService = Meteor["loginWith" + capitalize(serviceName)]
    options = {}

    if (Accounts.ui._options.requestPermissions[serviceName])
      options.requestPermissions = Accounts.ui._options.requestPermissions[serviceName]

    if (Accounts.ui._options.requestOfflineToken[serviceName])
      options.requestOfflineToken = Accounts.ui._options.requestOfflineToken[serviceName]

    loginWithService(options, callback)

    Router.go('/')

capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)
