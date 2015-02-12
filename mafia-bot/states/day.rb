class Day
	def initialize delegate, players, mafia
		puts "Starting State Day"
		State.send "It is now day time"
		State.send "Vote for who you think is the killer"
		@delegate = delegate
		@players = players
		@mafia = mafia
		@votes = {}
	end

	def command_received command, user
		case command[0]
		when "vote"
			if @players.include? user
				voted = @players.select {|player| player.name == command[1]}[0]
				if voted
					@votes[user] = voted
					puts "  #{voted.name} was voted for by #{user.name}"
					State.send "#{voted.name} was voted for by #{user.name}"
					if @votes.count == @players.count
						transition
					end
				else
					puts "  #{command[1]} is not playing"
					State.send "#{command[1]} is not playing"
				end
			else
				puts "  #{user.name} can not vote"
				State.send "You can not vote"
			end
		end
	end

	def transition
		State.send "Votes:"
		vote_count = Hash.new(0)
		@votes.values.each do |user|
			vote_count[user] +=1
		end
		vote_count.each {|user, count| State.send "#{user.name}: #{count}" }
		killed = vote_count.max_by{|k,v| v}[0]
		State.send "#{killed.name} was lynched"
		@players.delete killed
		@mafia.delete killed
		State.send "There are #{@players.count} players left"
		if @players.count-@mafia.count <= @mafia.count
			puts "Mafia won"
			State.send "Mafia win"
			@delegate.change_state New.new @delegate
		elsif @mafia.count == 0
			puts "Players won"
			State.send "Players win. The mafia was #{killed.name}"
			@delegate.change_state New.new @delegate
		else
			@delegate.change_state Night.new @delegate, @players, @mafia
		end
	end
end