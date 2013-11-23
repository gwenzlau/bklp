module APIHelper
  def to_json(obj)
    MultiJson.dump(obj, pretty: true)
  end

  def parse_json(json)
    MultiJson.load(json, symbolize_keys: true)
  end
end
