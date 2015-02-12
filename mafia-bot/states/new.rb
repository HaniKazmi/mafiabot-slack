class New
	def initialize delegate
		puts "Starting State New"
		@delegate = delegate
	end

	def command_received command, user
		if command[0] == "create"
			@delegate.change_state Create.new @delegate
		end
	end
end