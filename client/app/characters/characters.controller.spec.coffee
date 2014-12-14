'use strict'

describe 'Controller: CharactersController', ->

  # load the controller's module
  beforeEach module 'tapbogeApp'
  CharactersController = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CharactersController = $controller 'CharactersController',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
