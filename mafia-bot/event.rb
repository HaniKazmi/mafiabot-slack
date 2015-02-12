class Event
	attr_reader :type, :user, :text
	def initialize data
		event = JSON.parse data
		if event["type"]
			@type = event["type"].to_sym
			@user = State.users[event["user"]] ||= User.new(event["user"])
			@text = event["text"]
		end
	end
end