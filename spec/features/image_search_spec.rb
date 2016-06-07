require 'rails_helper'

feature 'image search' do

	scenario 'user can search for images and see the results on the page' do
		visit('/')
		click_link('Make meme')
		fill_in('Search',with:'Dogs')
		click_button('Search')
		
	end

end