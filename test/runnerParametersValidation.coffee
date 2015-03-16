expect = require 'expect.js'
RunnerParametersValidation = require '../src/runnerParametersValidation'

describe 'RunnerParametersValidation', ->
  describe 'isValid()', ->
    it 'should return true if property and predicate are set', ->
      expect(new RunnerParametersValidation(property: {}, predicate: {}).isValid()).to.be true

    it 'should return false if property is not set', ->
      expect(new RunnerParametersValidation(predicate: {}).isValid()).to.be false

    it 'should return false if predicate is not set', ->
      expect(new RunnerParametersValidation(property: {}).isValid()).to.be false

    it 'should return false if predicate and property are not set', ->
      expect(new RunnerParametersValidation({}).isValid()).to.be false

  describe 'getValidationError()', ->
    it 'should throw an error when the parameters are valid', ->
      expect(-> new RunnerParametersValidation(property: {}, predicate: {}).getValidationError()).to.throwError()

    it 'should return an error when property is not set', ->
      expect(new RunnerParametersValidation(predicate: {}).getValidationError()).to.be.an Error

    it 'should return an error when predicate is not set', ->
      expect(new RunnerParametersValidation(property: {}).getValidationError()).to.be.an Error

    it 'should return an error when predicate and property both are not set', ->
      expect(new RunnerParametersValidation({}).getValidationError()).to.be.an Error
