module FellownationApi
  require "net/http"
  require "uri"

  def request_webservius(path, values={}, method="")
    if method.blank?
      string_values = values.merge({"wsvKey" => WEBSERVIUS_KEY}).collect{|x| x.join("=")}.join("&")
      uri = URI.parse(WEBSERVIUS_PATH+"#{path}?#{string_values}")
      response = Net::HTTP.get_response(uri)
    elsif method == :post
      uri = URI.parse(WEBSERVIUS_PATH+"#{path}?wsvKey=#{WEBSERVIUS_KEY}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(values)
      response = http.request(request)
    end

    return response
  end
  
  def self.included(base)
    base.send :helper_method, :request_webservius if base.respond_to? :helper_method
  end
end