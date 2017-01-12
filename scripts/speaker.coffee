HubotSlack = require 'hubot-slack'

module.exports = (robot) ->
  exec = require('child_process').exec

  queue = []
  processing = false

  robot.catchAll (msg) ->
    matches = msg.message.text.match(/(.*)/i)
    text = matches[0]
    if processing
      return queue.push text

    runcommand = (text) ->
      processing = true
      exec "~/dev/remocon/run.sh #{text}", (err, stdout, stderr) ->
        if err || stderr
          return msg.send err || stderr
        if queue.length != 0
          runcommand queue.pop()
        else
          processing = false

    runcommand "#{text}"

    say = (text) ->
      processing = true
      exec "~/dev/jsay #{text}", (err, stdout, stderr) ->
        if err || stderr
          return msg.send err || stderr
        if queue.length != 0
          say queue.pop()
        else
          processing = false

    say "#{text}したよ"
    msg.send "#{text}したよ"
