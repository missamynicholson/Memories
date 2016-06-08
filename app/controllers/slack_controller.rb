class SlackController < ApplicationController

  def sending
    url = URI.parse("https://hooks.slack.com")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # request = Net::HTTP::Post.new("/services/T1F2NP42D/B1F6E66E8/#{ENV['SLACK_HOOK']}", {'Content-Type' =>'application/json'})
    request = Net::HTTP::Post.new(ENV['SLACK_HOOK'], {'Content-Type' =>'application/json'})
    request.body = {"text" => params[:text]}.to_json
    response = http.request(request)
    redirect_to '/'
  end

end
