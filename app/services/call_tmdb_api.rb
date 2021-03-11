class CallTmdbApi
  include HTTParty

  def self.call(endpoint)
    response = get(URI.encode("#{BASE_URL}#{endpoint}".force_encoding('ASCII-8BIT')), headers: HEADERS)
    response.success? ? JSON.parse(response.body, symbolize_names: true) : {}
  end
end
