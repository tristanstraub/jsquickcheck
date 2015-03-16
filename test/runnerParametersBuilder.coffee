expect = require 'expect.js'
RunnerParametersBuilder = require '../src/runnerParametersBuilder'

describe 'RunnerParametersBuilder', ->
  describe 'forAll()', ->
    it 'should return a new instance with forAll set', ->
      builder = new RunnerParametersBuilder()
      expect(builder.forAll 'dummy').to.not.be builder

    describe 'getParameters()', ->
      it 'should have property set', ->
        dummy = 'dummy'
        builder = new RunnerParametersBuilder()
        expect(builder.forAll(dummy).getParameters().property).to.be dummy

  describe 'skip()', ->
    it 'should return a new instance with skip set', ->
      builder = new RunnerParametersBuilder()
      expect(builder.skip 'dummy').to.not.be builder

    describe 'getParameters()', ->
      it 'should have skip set', ->
        dummy = 'dummy'
        builder = new RunnerParametersBuilder()
        expect(builder.skip(dummy).getParameters().skip).to.be dummy

  describe 'predicate()', ->
    it 'should return a new instance with predicate set', ->
      builder = new RunnerParametersBuilder()
      expect(builder.predicate 'dummy').to.not.be builder

    describe 'getParameters()', ->
      it 'should have predicate set', ->
        dummy = 'dummy'
        builder = new RunnerParametersBuilder()
        expect(builder.predicate(dummy).getParameters().predicate).to.be dummy

  describe 'repetitions()', ->
    it 'should return a new instance with repetitions set', ->
      builder = new RunnerParametersBuilder()
      expect(builder.repetitions 'dummy').to.not.be builder

    describe 'getParameters()', ->
      it 'should have repetitions set', ->
        dummy = 'dummy'
        builder = new RunnerParametersBuilder()
        expect(builder.repetitions(dummy).getParameters().repetitions).to.be dummy
