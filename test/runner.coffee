expect = require 'expect.js'
sinon = require 'sinon'
RunnerBuilder = require '../src/runnerBuilder'
ValidationError = require '../src/validationError'

describe 'Runner', ->
  describe 'getRunner()', ->
    describe 'when validation.isValid() is false', ->
      it 'should throw the error returned from getValidationError()', ->
        parametersValidationFactory = ->
          isValid: -> false
          getValidationError: -> new ValidationError()
        dummyParameters = {}

        builder = new RunnerBuilder({parametersValidationFactory})
        expect(-> builder.getRunner()).to.throwException (e) ->
          expect(e).to.be.a ValidationError


    describe 'when validation.isValid() is true', ->
      it 'should call runnerFactory()', ->
        runnerFactory = sinon.spy()
        parametersValidationFactory = ->
          isValid: -> true
        dummyParameters = {}

        new RunnerBuilder({runnerFactory, parametersValidationFactory}).getRunner(dummyParameters)

        expect(runnerFactory.calledOnce).to.be true
