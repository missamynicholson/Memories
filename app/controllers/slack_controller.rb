class SlackController < ApplicationController

  def sending
    url = URI.parse("https://hooks.slack.com")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(xxxxxxxxxxx, {'Content-Type' =>'application/json'})
    request.body = {"text" => params[:text]}.to_json
    response = http.request(request)
    redirect_to '/'
  end

end
