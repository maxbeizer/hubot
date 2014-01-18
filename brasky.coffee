# Description:
# In loving memory of Bill Brasky
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot brasky me - returns a random eulogism
#
# Author:
#   maxbeizer

braskyisms = []
regex = /<li>(.+)(?:\W)<\/li>/g

module.exports = (robot) ->
  robot.respond /brasky( me)?/i, (msg) ->
    msg.http('http://www.psychonoble.com/subpages/quotes.html')
      .get() (err, res, body) ->
        match = []
        braskyisms.push match[1].split(";")  while (match = regex.exec(body))?

        if braskyisms? && braskyisms.length
          msg.send "#{msg.random braskyisms}"
        else
          msg.send 'Sorry, Mate! I have messed the bed. :poop:'

