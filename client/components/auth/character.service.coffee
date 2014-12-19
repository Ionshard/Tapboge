'use strict'

angular.module 'tapbogeApp'
.factory 'Character', ($resource) ->
  $resource '/api/characters/:id',
    id: '@_id'
  ,
    active:
      method: 'GET'
      params:
        id: 'active'

    activate:
      method: 'PUT'
      params:
        id: 'active'

    deactivate:
      method: 'DELETE'
      params:
        id: 'active'
