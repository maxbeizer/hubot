# Description:
#   gets dev/strat said it tweets
#
# Dependencies:
#   "twit": "1.1.6"
#
# Configuration:
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN
#   HUBOT_TWITTER_ACCESS_TOKEN_SECRET
#
# Commands:
#   hubot adevsaidit            - gets the latest adevsaidit tweet
#   hubot adevsaidit random     - gets a random adevsaidit tweet
#   hubot astratsaidit          - gets the latest astratsaidit tweet
#   hubot astratsaidit random   - gets a random astratsaidit tweet
#
# Author:
#   maxbeizer, very closely based off of the good work of: KevinTraver
#

Twit = require "twit"
config =
  consumer_key: process.env.HUBOT_TWITTER_CONSUMER_KEY
  consumer_secret: process.env.HUBOT_TWITTER_CONSUMER_SECRET
  access_token: process.env.HUBOT_TWITTER_ACCESS_TOKEN
  access_token_secret: process.env.HUBOT_TWITTER_ACCESS_TOKEN_SECRET

module.exports = (robot) ->
  twit = undefined

  robot.respond /(adevsaidit|astratsaidit)(\s+random)?/i, (msg) ->
    unless config.consumer_key
      msg.send "Please set the HUBOT_TWITTER_CONSUMER_KEY environment variable."
      return
    unless config.consumer_secret
      msg.send "Please set the HUBOT_TWITTER_CONSUMER_SECRET environment variable."
      return
    unless config.access_token
      msg.send "Please set the HUBOT_TWITTER_ACCESS_TOKEN environment variable."
      return
    unless config.access_token_secret
      msg.send "Please set the HUBOT_TWITTER_ACCESS_TOKEN_SECRET environment variable."
      return

    unless twit
      twit = new Twit config

    screen_name = msg.match[1]
    if msg.match[2] then count = 50 else count = 1

    twit.get "statuses/user_timeline",
      screen_name: screen_name
      count: count
      include_rts: false
      exclude_replies: true
    , (err, reply) ->
      if count > 1 then tweet_id = reply[Math.floor(Math.random() * reply.length)] else tweet_id = reply[0]
      return msg.send "Ouch! I'm having an episode." if err
      return msg.send "https://twitter.com/#{screen_name}/status/#{tweet_id['id_str']}"
