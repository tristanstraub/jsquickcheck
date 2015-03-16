_ = require 'lodash'

module.exports = class RunnerParametersBuilder
  constructor: (@parameters = {}) ->
    @parameters ?= {}

  getParameters: -> return @parameters

  # -- IParametersBuilder
  forAll: (property) -> @_next {property}
  predicate: (predicate) -> @_next {predicate}
  skip: (skip) -> @_next {skip}
  repetitions: (repetitions) -> @_next {repetitions}

  # -- private --
  _next: (newParameters) -> new RunnerParametersBuilder _.extend {}, @parameters, newParameters
