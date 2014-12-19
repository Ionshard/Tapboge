'use strict'

angular.module 'tapbogeApp'
.factory 'User', ($resource) ->
  $resource '/api/users/:id/:controller',
    id: '@_id'
  ,
    changePassword:
      method: 'PUT'
      params:
        controller: 'password'

    get:
      method: 'GET'
      params:
        id: 'me'

    characters:
      method: 'GET'
      isArray: true
      params:
        id: 'me'
        controller: 'characters'

