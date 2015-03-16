
getRandomInt = (min, max) ->
  return min + Math.floor(Math.random() * (max - min + 1))

getYear = (start, end) ->
  getRandomInt start.getFullYear(), end.getFullYear()

getMonth = (start, end, year) ->
  startYear = start.getFullYear()
  endYear = end.getFullYear()

  startMonth = if startYear is endYear or startYear is year then start.getMonth() else 0
  endMonth = if startYear is endYear or endYear is year then end.getMonth() else 11

  getRandomInt startMonth, endMonth

daysInMonth = (year, month) ->
  return new Date(year, month + 1, 0).getDate()

getDay = (start, end, year, month) ->
  startYear = start.getFullYear()
  endYear = end.getFullYear()
  startMonth = start.getMonth()
  endMonth = end.getMonth()

  startDay = if (startYear is endYear and startMonth is endMonth) or
    (startYear is year and startMonth is month) then start.getDate() else 1
  endDay = if (startYear is endYear and startMonth is endMonth) or
    (endYear is year and endMonth is month) then end.getDate() else daysInMonth(year, month)

  getRandomInt startDay, endDay

resolve = (value) ->
  if typeof value is 'function'
    value()
  else
    value

module.exports = (start, end, dateFactory) ->
  ->
    start = resolve(start)
    end = resolve(end)

    year = getYear start, end
    month = getMonth start, end, year
    day = getDay start, end, year, month

    if dateFactory
      return dateFactory year, month, day
    else
      return new Date year, month, day
