=begin
class PostmarkController < Postmark::ApiClient

def send
	your_api_key = '516df9ef-26a9-40b3-8f5b-96afa4da000a'
	client = Postmark::ApiClient.new(your_api_key, secure: true)
end=end
