module MemesHelper
	def url_convert(string)
		string.gsub(/ /,'%20')
	end

	def getty_request(search)
		p "Here is the key...."
		p ENV['GETTY_ACCESS_KEY']
		url = URI.parse("https://api.gettyimages.com")
		search_url = "/v3/search/images?fields=id,title,comp,referral_destinations&sort_order=best&phrase=#{search}"
		req = Net::HTTP::Get.new(search_url)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		req['Api-Key']=ENV['GETTY_ACCESS_KEY']
		response = http.start do |http|
  		http.request(req)
		end
		translate_response(response)
	end

	def translate_response(response)
		response = JSON.parse(response.body)
		response = response["images"].map{ |image| image["display_sizes"][0]["uri"]}
	end
end
