class Create
	def initialize delegate
		puts "Starting State Create"
		State.send "Waiting for players"
		@delegate = delegate
		@players = []
	end

	def command_received command, user
		case command[0]
		when "join"
			unless @players.include? user
				@players << user
				puts "  #{user.name} joined"
				State.send "#{user.name} joined"
			else
				puts "  #{user.name} is already in the gane"
				State.send "#{user.name} is already in the gane"
			end
		when "start"
			puts "Starting State Start"
			State.send 'Starting game'
			@mafia = @players.sample 1
			puts "There are #{@mafia.count} mafia members."
			State.send "There are #{@players.count} players"
			State.send "#{@mafia.count} of them is a mafia member."
			State.send "You are a mafia member", @mafia[0].channel
			@delegate.change_state Night.new @delegate, @players, @mafia
		end
	end
end