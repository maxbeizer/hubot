# Description:
#   Show a list of available bcycles bikes and docks near the Centresource office
#
# Dependencies:
#   None
#
# Configuration:
#   None
#   Must know the number of the station at this point
#   2180: 5th and Monroe
#   2179: Farmer's Market
#   2165: 5th and Church (Arcade)
#   2162: Commerce and Second
#
# Commands:
#   hubot bcycle - returns name, available bikes, available docks
#
# Authors:
#   maxbeizer

module.exports = (robot) ->
  robot.respond /bcycle/i, (msg) ->
    msg.http('http://api.bcycle.com/Services/Mobile.svc/ListKiosks')
      .get() (err, res, body) ->
        return msg.send "Error!" if err
        parsed = JSON.parse(body)
        arr = parsed['d']['list']
        arr.map (loc) ->
          if loc['Id'] == 2180 || loc['Id'] == 2179 || loc['Id'] == 2162 || loc['Id'] == 2165
            msg.send "#{loc['Name']} -->\n\tAvailable: #{loc['BikesAvailable']}\n\tOpen: #{loc['DocksAvailable']}"
