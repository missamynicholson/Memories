require 'rails_helper'

feature 'image search' do

	scenario 'logged in user can search for images and see the results on the page' do
		sign_up
		search
		expect(page).to have_css("img[src*='http://google.com/images/test']")
	end

	scenario 'logged in user can search using more than one word' do
		sign_up
		search(searchterm: 'Angry dog')
		expect(page).to have_css("img[src*='http://google.com/images/test']")
	end

  scenario 'logged in user can select an image' do
    sign_up
    search
    click_link('0')
    expect(page).to have_content("Image added to meme")
    expect(Meme.all.count).to equal(1)
  end

  scenario 'non-logged in user cannot make a meme' do
    visit('/')
		click_link('Make meme')
    expect(current_path).to eq(new_user_session_path)
  end

end
