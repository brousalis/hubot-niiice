axios = require('axios')
storage = require('./storage')

module.exports = (robot) ->
  storage = new Storage(robot)

  reaction = (msg, name) ->
    payload = {
      name: name
      timestamp: msg.message.rawMessage.ts
      channel: msg.message.rawMessage.channel
      token: process.env.HUBOT_SLACK_TOKEN
    }

    url = "https://slack.com/api/reactions.add?token=#{payload.token}&name=#{payload.name}&timestamp=#{payload.timestamp}&channel=#{payload.channel}"

    axios
      .get (url)
      .then (res) -> return true
      .catch (err) -> return false

  robot.hear /\b69\b/, (msg) ->
    reaction(msg, 'niiice')
    storage.add('69')

  robot.hear /\b420\b/, (msg) ->
    reaction(msg, 'niiice')
    storage.add('420')

  robot.respond /how niiice/, (msg) ->
    scores = storage.scores()
    msg.send(scores)
