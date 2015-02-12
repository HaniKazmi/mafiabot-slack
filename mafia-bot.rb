require 'faye/websocket'
require 'eventmachine'
require_relative 'mafia-bot/authentication'
require_relative 'mafia-bot/event'
require_relative 'mafia-bot/user'
require_relative 'mafia-bot/logic'
require_relative 'mafia-bot/states/states'

url = get_url State.token

EM.run {
  ws = Faye::WebSocket::Client.new(url)
  State.ws = ws
  logic = Logic.new

  ws.on :open do |event|
    p [:open]
  end

  ws.on :message do |event|
    data = Event.new event.data
    p [:message, event.data]
    logic.new_event data
    	#ws.send('{"id": 1,"type": "message","channel": "C03LB019E","text": "Hello world"}')
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}