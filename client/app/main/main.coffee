'use strict'

angular.module 'tapbogeApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'app/main/main.html'
    controller: 'MainController'
    public: true
