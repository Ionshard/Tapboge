'use strict'

describe 'Controller: CharactersController', ->

  # load the controller's module
  beforeEach module 'tapbogeApp'
  CharactersController = undefined
  $scope = undefined
  $httpBackend = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, _$rootScope_, _$httpBackend_) ->
    $scope = _$rootScope_.$new()
    CharactersController = $controller 'CharactersController',
      $scope: $scope
    $httpBackend = _$httpBackend_

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'should request characters', ->
    $httpBackend.expectGET('/api/users/me/characters').respond [
      {name: "Character1"},
      {name: "Character2"}
    ]

    $scope.$apply ->
      $scope.init()

    $httpBackend.flush()
    names = _.pluck($scope.characters, 'name')
    expect(names).toContain("Character1")
    expect(names).toContain("Character2")
