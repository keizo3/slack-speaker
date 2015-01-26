module.exports = (robot) ->
  exec = require('child_process').exec

  queue = []
  processing = false

  robot.hear /(.*)/, (msg) ->
    text = "#{msg.match[1]}"
    if processing
      return queue.push text

    say = (text) ->
      processing = true
      exec "~/jsay #{text}", (err, stdout, stderr) ->
        if err || stderr
          return msg.send err || stderr
        if queue.length != 0
          say queue.pop()
        else
          processing = false
    say text

