class Storage
  constructor: (@robot) ->
    storageLoaded = =>
      @storage = @robot.brain.data.niiiice ||= {
        scores: {}
      }

    @robot.brain.on('loaded', storageLoaded)
    storageLoaded()

  add: (number) ->
    @storage.scores[number] ||= 0
    @storage.scores[number]++

  scores: ->
    @storage.scores

module.exports = Storage
