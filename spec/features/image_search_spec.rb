require 'rails_helper'

feature 'image search' do

	scenario 'user can search for images and see the results on the page' do
		search
		expect(page).to have_css("img[src*='testimageuri']")
	end

	scenario 'user can search using more than one word' do
		search(searchterm: 'Angry dog')
		expect(page).to have_css("img[src*='testimageuri']")
	end

end
