'use strict'

angular.module 'tapbogeApp'
.config ($routeProvider) ->
  $routeProvider.when '/game',
    templateUrl: 'app/game/game.html'
    controller: 'GameController'
