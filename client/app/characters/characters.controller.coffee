'use strict'

angular.module 'tapbogeApp'
.controller 'CharactersController', ($scope, $http, Auth) ->
  $scope.init = ->
    $characters = $http.get('/api/users/me/characters').success (data) ->
      $scope.characters = data

  $scope.init()
