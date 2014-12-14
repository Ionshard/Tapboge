'use strict'

angular.module 'tapbogeApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/login',
    templateUrl: 'components/login/login.html'
    controller: 'LoginController'
    public: true

  .when '/signup',
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupController'
    public: true

  .when '/settings',
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsController'
