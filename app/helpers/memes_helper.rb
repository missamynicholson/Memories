module MemesHelper
	def url_convert(string)
		string.gsub(/ /,'%20').gsub('?', '%3F')
	end

	def getty_request(search)
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

	def upload_image(raw_image_url)
		Cloudinary::Uploader.upload(raw_image_url)
	end

	def transform_image(meme, meme_params)
		public_id = upload_image(meme.raw_image_url)["public_id"]
		url_top = url_convert(meme_params[:top_caption])
		url_bottom = url_convert(meme_params[:bottom_caption])
		Cloudinary::Utils.cloudinary_url(public_id, :transformation => [
				{:overlay => "text:helvetica_40_bold:#{url_top}",
				:gravity => :north },
				{:overlay => "text:helvetica_40_bold:#{url_bottom}",
				:gravity => :south }])
	end
end
