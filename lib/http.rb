require 'net/http'

# The Http module exports Http.get, which returns the body of an URL, and is able to follow
# a certain number of redirections.
#
module Http
  def self.get(uri, redirects_left=10)
    response = Net::HTTP.get_response(URI(uri))
    case response
    when Net::HTTPSuccess
      response.body
    when Net::HTTPRedirection
      if redirects > 0
        get(response['Location'], redirects_left-1)
      else
        raise "Too many redirects (> 10)"
      end
    else
      raise "Failed to fetch #{uri}, status: #{response.code}"
    end
  end
end
