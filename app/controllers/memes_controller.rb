require 'net/http'
require 'uri'

class MemesController < ApplicationController

	def index
	end

	def get_images
		url = URI.parse("https://api.gettyimages.com")
		search_url = "/v3/search/images?fields=id,title,thumb,referral_destinations&sort_order=best&phrase=#{params[:search]}"
		req = Net::HTTP::Get.new(search_url)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		req['Api-Key']=ENV['GETTY_ACCESS_KEY']
		response = http.start do |http| 
  		http.request(req)
		end
		p response.body
		# redirect_to request.referer
	end

	def new
		
		# render the images on the page for the user to choose
		# choose image
	end

end
