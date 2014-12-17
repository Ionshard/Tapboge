'use strict'

angular.module 'tapbogeApp'
.controller 'LoginController', ($scope, Auth, $location, $window) ->
  $scope.user = {}
  $scope.errors = {}
  $scope.login = (form) ->
    $scope.submitted = true

    if form.$valid
      # Logged in, redirect to home
      Auth.login
        email: $scope.user.email
        password: $scope.user.password

      .then ->
        Auth.getCurrentCharacter().$promise
        .then (data) ->
          if data.hasOwnProperty 'active'
            $location.path '/game'
          else
            $location.path '/characters'
            
        .catch (err) ->
          $scope.errors.other = err.message

      .catch (err) ->
        $scope.errors.other = err.message

  $scope.loginOauth = (provider) ->
    $window.location.href = '/auth/' + provider
