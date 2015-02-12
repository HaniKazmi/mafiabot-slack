require_relative 'new'
require_relative 'create'
require_relative 'night'
require_relative 'day'

class State
	class << self
		attr_accessor :token, :users, :ws

		def send message, channel = 'C03LB019E'
			@ws.send "{\"id\": #{@message_id+=1},\"type\": \"message\",\"channel\": \"#{channel}\",\"text\": \"#{message}\"}"
		end
	end

	@token = ENV["SLACK_API_KEY"]
	@users = {}
	@ws = nil
	@message_id = 1
end