module ApiHelper
  include Rack::Test::Methods
  include Warden::Test::Helpers
  Warden.test_mode!

  def app
    Rails.application
  end

  def get_json(url)
    get url
    parse_json(last_response.body)
  end

  def post_json(url, params)
    post url, params
    parse_json(last_response.body)
  end

  def parse_json(json)
    MultiJson.load(json, symbolize_keys: true)
  end

  def sign_in_as()
  end
end

RSpec.configure do |config|
  config.include ApiHelper, :type=>:api #apply to all spec for apis folder
end
