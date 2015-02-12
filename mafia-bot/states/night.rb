class Night
	def initialize delegate, players, mafia
		puts "Starting State Night"
		State.send "It is now night time"
		@delegate = delegate
		@players = players
		@mafia = mafia
	end

	def command_received command, user
		case command[0]
		when "kill"
			if @mafia.include? user
				killed = @players.select {|player| player.name == command[1]}[0]
				if killed
					puts "  #{killed.name} was killed"
					State.send "#{killed.name} was killed"
					@players.delete killed
					@mafia.delete killed
					transition
				else
					puts "  Invalid selection"
					State.send "#{command[1]} can not be killed"
				end
			else
				puts "  #{user.name} is not a killer"
				State.send "You are not a killer"
			end
		end
	end

	def transition
		State.send "There are #{players.count} players left"
		if @players.count-@mafia.count <= @mafia.count
			puts "Mafia won"
			State.send "Mafia win"
			@delegate.change_state New.new @delegate
		elsif @mafia.count == 0
			puts "Players won"
			State.send "Players win"
			@delegate.change_state New.new @delegate
		else
			@delegate.change_state Day.new @delegate, @players, @mafia
		end
	end
end