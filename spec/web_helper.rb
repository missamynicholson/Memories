require 'fileutils'

def search(searchterm:'Dogs')
	url_search = searchterm.gsub(/ /,'%20')
	json_response = {'images' => [{'display_sizes' => [{'uri' => 'http://google.com/images/test'}]}]}.to_json
	stub_request(:get, "https://api.gettyimages.com/v3/search/images?fields=id,title,comp,referral_destinations&phrase=#{url_search}&sort_order=best").
       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
       to_return(:status => 200, :body => json_response, :headers => {})
  visit('/')
	click_link('Make meme')
	fill_in('Search',with: searchterm)
	click_button('Search')
end

def log_in(user = {email: "amy@gmail.com", password: "testtest"})
	visit("/")
	click_link("Login")
	fill_in("Email", with: user[:email])
	fill_in("Password", with: user[:password])
	click_button("Login")
end

def sign_up(username = "myUsername")
	visit("/")
	click_link("Sign up")
	click_link("Sign up", match: :first)
	fill_in("Username", with: username)
	fill_in("Email", with: "test@example.com")
	fill_in("Password", with: "testtest")
	fill_in("Password confirmation", with: "testtest")
	click_button("Sign up")
end

def remove_uploaded_file
	FileUtils.rm_rf(Rails.root + "public/system")
end