# Description:
#   From America's Finest News Source, this script brings the best of the Newswire.
#   All content is copyright of its respective owner
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot onion me - returns a random headline from the current newswire
#
# Author:
#   maxbeizer

headlines = []
regex = /<h1><a class="title" data-article-id=".+" data-prefetch=".+" href=".+" title=".+">(.+?)<\/a><\/h1>/ig

module.exports = (robot) ->
  robot.respond /onion( me)?/i, (msg) ->
    msg.http('http://www.theonion.com/features/newswire/')
      .get() (err, res, body) ->
        match = []
        headlines.push match[1].split(";")  while (match = regex.exec(body))?
        headlines.pop() #remove the crufty last element

        if headlines? && headlines.length
          msg.send "#{msg.random headlines} — The Onion Newswire"
        else
          msg.send 'Sorry, Mate! I have messed the bed. :poop:'
