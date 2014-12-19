'use strict'

describe 'Controller: MainController', ->

  # load the controller's module
  beforeEach module 'tapbogeApp'
  beforeEach module 'socketMock'

  MainController = undefined
  scope = undefined
  $httpBackend = undefined

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope) ->
    $httpBackend = _$httpBackend_
    scope = $rootScope.$new()
    MainController = $controller 'MainController',
      $scope: scope

  it 'should attach a version to the scope', ->
    expect(scope.version).toBe '0.1'