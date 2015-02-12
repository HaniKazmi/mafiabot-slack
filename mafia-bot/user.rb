class User
	attr_reader :id, :name, :channel
	def initialize id
		if id
			data = get_data id
			@id = id
			@name = data["user"]["name"]
			im = get_im id
			@channel = im["channel"]["id"]
		end
	end

	def get_data id
	    url = 'https://slack.com/api'
	    req = Net::HTTP.post_form URI(url + '/users.info'), token: State.token, user: id
	    body = JSON.parse req.body
	end

	def get_im id
		url = 'https://slack.com/api'
	    req = Net::HTTP.post_form URI(url + '/im.open'), token: State.token, user: id
	    body = JSON.parse req.body
	end
end