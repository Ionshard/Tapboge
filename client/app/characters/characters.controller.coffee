'use strict'

angular.module 'tapbogeApp'
.controller 'CharactersController', ($scope, $http, $location, Auth) ->

  $scope.characters = Auth.getCharacters()
  $scope.newCharacter = {}

  $scope.createCharacter = (form) ->
    if form.$valid
      Auth.createCharacter $scope.newCharacter, (character) ->
        $scope.newCharacter = {}
        $location.path '/game'


  $scope.activateCharacter = (id) ->
    Auth.activateCharacter id, ->
      $location.path '/game'
