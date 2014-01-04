# Description:
#   Display Ballmer at his best
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   devs|developers - display THE Ballmer gif
#
# Author:
#   maxbeizer

module.exports = (robot) ->
  robot.hear /\bdevs\b|\bdevelopers\b/i, (msg)->
    msg.send "http://i.imgur.com/9rrJe2I.gif"
