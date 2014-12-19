'use strict'

angular.module 'tapbogeApp'
.factory 'Auth', ($location, $rootScope, $http, User, Character, $cookieStore, $q) ->
  currentUser = if $cookieStore.get 'token' then User.get() else {}
  currentCharacter = if $cookieStore.get 'token' then Character.active() else {}

  ###
  Authenticate user and save token

  @param  {Object}   user     - login info
  @param  {Function} callback - optional
  @return {Promise}
  ###
  login: (user, callback) ->
    deferred = $q.defer()

    $http.post '/auth/local',
      email: user.email
      password: user.password

    .success (data) ->
      $cookieStore.put 'token', data.token
      currentUser = User.get()
      currentCharacter = Character.active()
      deferred.resolve data
      callback?()

    .error (err) =>
      @logout()
      deferred.reject err
      callback? err

    deferred.promise


  ###
  Delete access token and user info

  @param  {Function}
  ###
  logout: ->
    $cookieStore.remove 'token'
    currentUser = {}
    currentCharacter = {}
    return


  ###
  Create a new user

  @param  {Object}   user     - user info
  @param  {Function} callback - optional
  @return {Promise}
  ###
  createUser: (user, callback) ->
    User.save user,
      (data) ->
        $cookieStore.put 'token', data.token
        currentUser = User.get()
        callback? user

      , (err) =>
        @logout()
        callback? err

    .$promise


  ###
  Change password

  @param  {String}   oldPassword
  @param  {String}   newPassword
  @param  {Function} callback    - optional
  @return {Promise}
  ###
  changePassword: (oldPassword, newPassword, callback) ->
    User.changePassword
      id: currentUser._id
    ,
      oldPassword: oldPassword
      newPassword: newPassword

    , (user) ->
      callback? user

    , (err) ->
      callback? err

    .$promise


  ###
  Gets all available info on authenticated user

  @return {Object} user
  ###
  getCurrentUser: ->
    currentUser

  ###
  Gets currently active character

  @return {Object} character
  ###
  getCurrentCharacter: ->
    currentCharacter

  ###
  Activates character
  @param {String} id
  @return {Promise}
  ###

  activateCharacter: (id) ->
    $http.put('/api/characters/active', {id: id})
    .success ->
      currentCharacter = Character.active()

  ###
  Deactivates current user's characters

  @return {HttpPromise}
  ###

  deactivateCharacters: ->
    $http.delete('/api/characters/active')
    .success ->
      currentCharacter = {}

  ###
  Check if a user is logged in synchronously

  @return {Boolean}
  ###
  isLoggedIn: ->
    currentUser.hasOwnProperty 'role'


  ###
  Check if a user has an active character synchronously

  @return {Boolean}
  ###
  hasCurrentCharacter: ->
    currentCharacter.hasOwnProperty 'active'


  ###
  Waits for currentUser to resolve before checking if user is logged in
  ###
  isLoggedInAsync: (callback) ->
    if currentUser.hasOwnProperty '$promise'
      currentUser.$promise.then ->
        callback? true
      .catch ->
        callback? false

    else
      callback? currentUser.hasOwnProperty 'role'

  ###
  Check if a user is an admin

  @return {Boolean}
  ###
  isAdmin: ->
    currentUser.role is 'dev'


  ###
  Get auth token
  ###
  getToken: ->
    $cookieStore.get 'token'
