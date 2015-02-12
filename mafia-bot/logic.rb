class Logic
	def initialize
		@state = New.new self
	end

	def new_event event
		if event.type == :message
			new_message event.text, event.user
		end
	end

	def new_message message, user
		if message.start_with? 'm'
			command = message.split(" ")[1..-1]
			@state.command_received command, user
		end
	end

	def change_state state
		@state = state
	end
end