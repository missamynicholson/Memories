class SlackController < ApplicationController

  def sending
    if params[:codeword].downcase == ENV['CODE_WORD']
      flash[:notice]='Correct codeword'
      url = URI.parse("https://hooks.slack.com")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(ENV['SLACK_HOOK'], {'Content-Type' =>'application/json'})
      request.body = {"text" => params[:text]}.to_json
      response = http.request(request)
      redirect_to '/'
    else
      flash[:alert]='Incorrect codeword'
      redirect_to '/'
    end
  end

end
