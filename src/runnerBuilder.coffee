_ = require 'lodash'

RunnerParametersBuilder = require './runnerParametersBuilder'
RunnerParametersValidation = require './runnerParametersValidation'
Runner = require './runner'

module.exports = class RunnerBuilder
  constructor: ({@parametersBuilder, @runnerFactory, @parametersValidationFactory} = {}) ->
    @runnerFactory ?= -> new Runner arguments...
    @parametersBuilder ?= new RunnerParametersBuilder()
    @parametersValidationFactory ?= -> new RunnerParametersValidation arguments...

  run: (cb) ->
    @getRunner().run cb

  getRunner: ->
    parameters = @parametersBuilder.getParameters()
    validation = @parametersValidationFactory parameters

    if !validation.isValid() then throw validation.getValidationError()

    return @runnerFactory parameters

  # -- IParametersBuilder
  forAll: (property) -> @_next @parametersBuilder.forAll property
  predicate: (predicate) -> @_next @parametersBuilder.predicate predicate
  skip: (skip) -> @_next @parametersBuilder.skip skip
  repetitions: (repetitions) -> @_next @parametersBuilder.repetitions repetitions

  _next: (parametersBuilder) -> new RunnerBuilder _.extend {}, this, {parametersBuilder}
