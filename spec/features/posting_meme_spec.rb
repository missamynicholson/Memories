require 'rails_helper'

feature 'Posting meme' do
  scenario 'Post image' do
    allow(Cloudinary::Uploader).to receive(:upload).and_return({image_url:'test'})
		sign_up
		search
    click_link('0')
    fill_in("Top caption", with: "Hi Adam")
    fill_in("Bottom caption", with: "Bye Adam")
    click_button("Update Meme")
    expect(page).to have_content("Meme created")
	end
end
