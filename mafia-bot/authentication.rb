require 'net/http'
require 'json'

def get_url
    req = Net::HTTP.post_form URI(State.url + '/rtm.start'), token: State.token
    body = JSON.parse req.body
    body['url']
end