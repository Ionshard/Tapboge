'use strict'

describe 'Controller: GameController', ->

  # load the controller's module
  beforeEach module 'tapbogeApp'
  GameController = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    GameController = $controller 'GameController',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
