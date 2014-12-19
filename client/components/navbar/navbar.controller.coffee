'use strict'

angular.module 'tapbogeApp'
.controller 'NavbarController', ($scope, $location, Auth) ->
  $scope.menu = {
    game: [
      title: 'Game', link: '/game'
    ],
    character: [
      title: 'Characters', link: '/characters'
    ],
    public: [
      title: "Home", link: '/'
    ]
  }


  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.hasCurrentCharacter = Auth.hasCurrentCharacter
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser
  $scope.getCurrentCharacter = Auth.getCurrentCharacter

  $scope.state = ->
    if $scope.isLoggedIn()
      if $scope.hasCurrentCharacter()
        return 'game'
      else
        return 'character'
    else
      return 'public'

  $scope.logout = ->
    Auth.deactivateCharacters().success ->
      Auth.logout()
    $location.path '/'

  $scope.changeCharacters = ->
    Auth.deactivateCharacters()
    $location.path '/characters'

  $scope.isActive = (route) ->
    route is $location.path()