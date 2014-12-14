'use strict'

angular.module 'tapbogeApp'
.config ($routeProvider) ->
  $routeProvider.when '/characters',
    templateUrl: 'app/characters/characters.html'
    controller: 'CharactersController'
