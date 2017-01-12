export HUBOT_SLACK_TOKEN=

#forever start -c coffee bin/hubot -a slack
forever start -w -c coffee node_modules/.bin/hubot -a slack
