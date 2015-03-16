_ = require 'lodash'
assert = require 'assert'
quickcheck = require '../src/index'
{generators} = quickcheck

describe 'quickcheck/forAll()', ->
  it 'should run random tests based on the given property', (done) ->
    utcDateFactory = -> new Date Date.UTC arguments...
    builder = quickcheck.forAll generators.object
      now: generators.date(new Date('2013-01-01'), new Date('2014-12-31'), utcDateFactory)
      start: generators.date(new Date('2013-01-01'), new Date('2014-12-31'), utcDateFactory)
      end: generators.date(new Date('2013-01-01'), new Date('2014-12-31'), utcDateFactory)

    builder
      # Many repetitions required to expose the flaw in now.toISOString() > lineItem.endDate
      .repetitions(100)
      .predicate ({now, start, end}, cb) ->
        assert now instanceof Date
        assert start instanceof Date
        assert end instanceof Date
        cb()
      .run done

  it 'should generate random objects', (done) ->
    generator = (depth) ->
      if depth <= 0 then return generators.oneOf(null, generators.string(), generators.integer())

      generators.oneOf(
        generators.array(generators.integer(0, 4), generator(depth - 1))
        generators.object(generators.array(generators.integer(1, 2), generators.string()), generator(depth - 1))
        generators.oneOf(null, generators.string(), generators.integer())
      )

    builder = quickcheck.forAll generators.object thing: generator(3)

    builder
      # Many repetitions required to expose the flaw in now.toISOString() > lineItem.endDate
      .repetitions(100)
      .predicate ({thing}, cb) -> cb()
      .run done
