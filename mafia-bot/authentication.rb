require 'net/http'
require 'json'

def get_url token
    url = 'https://slack.com/api'
    req = Net::HTTP.post_form URI(url + '/rtm.start'), token: token
    body = JSON.parse req.body
    body['url']
end