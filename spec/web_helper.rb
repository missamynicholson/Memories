def search(searchterm:'Dogs')
	url_search = searchterm.gsub(/ /,'%20')
	json_response = {'images' => [{'display_sizes' => [{'uri' => 'testimageuri'}]}]}.to_json
	stub_request(:get, "https://api.gettyimages.com/v3/search/images?fields=id,title,comp,referral_destinations&phrase=#{url_search}&sort_order=best").
       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Api-Key'=>ENV['GETTY_ACCESS_KEY'], 'User-Agent'=>'Ruby'}).
       to_return(:status => 200, :body => json_response, :headers => {})		
  visit('/')
	click_link('Make meme')
	fill_in('Search',with: searchterm)
	click_button('Search')
end