require 'erb'

module MemesHelper

	def url_convert(string)
		encoded_string = ERB::Util.url_encode(string)
		encoded_string.gsub(/,/,'%E2%80%9A')
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
		Cloudinary::Utils.cloudinary_url(public_id, transform_settings(url_top,url_bottom))
	end

	def transform_settings(url_top,url_bottom)
		{:transformation => [
				{:overlay => "text:helvetica_35_bold_line_spacing_0_center_stroke:#{url_top}", :color => "white", :border=>"5px_solid_black",
				:gravity => :north, :crop => "fit", :width => 320 },
				{:overlay => "text:helvetica_35_bold_line_spacing_0_center_stroke:#{url_bottom}", :color => "white", :border=>"5px_solid_black",
				:gravity => :south, :crop => "fit", :width => 320 }]}
	end

end
