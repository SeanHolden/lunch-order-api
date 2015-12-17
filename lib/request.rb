class Request
  attr_reader :url, :body
  private :url, :body

  def initialize(url, body)
    @url, @body = url, body
  end

  def post
    connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end
  end

  private

  def connection
    Faraday.new(url: url) do |faraday|
      faraday.response(:logger)
      faraday.adapter(Faraday.default_adapter)
    end
  end
end
