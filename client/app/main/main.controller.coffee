'use strict'

angular.module 'tapbogeApp'
.controller 'MainController', ($scope, $http, socket, Auth) ->
  $scope.version = '0.1'

  $scope.features = [
    'Account Creation'
    'Character Creation'
    'Character Selection'
  ]
  $scope.isLoggedIn = Auth.isLoggedIn