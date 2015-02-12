class User
	attr_reader :id, :name, :channel
	def initialize id
		if id
			data = get_data '/users.info', id
			@id = id
			@name = data["user"]["name"]
			im = get_data '/im.open', id
			@channel = im["channel"]["id"]
		end
	end

	def get_data endpoint, id
	    req = Net::HTTP.post_form URI(State.url + endpoint), token: State.token, user: id
	    body = JSON.parse req.body
	end
end