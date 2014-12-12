'use strict'

angular.module 'tapbogeApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/login',
    templateUrl: 'app/account/login/login.html'
    controller: 'LoginController'

  .when '/signup',
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupController'

  .when '/settings',
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsController'
    authenticate: true
