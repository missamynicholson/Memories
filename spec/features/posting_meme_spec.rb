require 'rails_helper'

feature 'Posting meme' do
  scenario 'Post image' do
    allow(Cloudinary::Uploader).to receive(:upload).and_return({image_url:'test'})
		sign_up
		search
    click_link('0')
    fill_in("Top caption", with: "Hi Adam")
    fill_in("Bottom caption", with: "Bye Adam")
    meme = Meme.find_by(raw_image_url: 'http://google.com/images/test')
    allow(URI).to receive(:parse).and_return((Rails.root + 'spec/files/images/confused_dog.png').open)
    click_button("Update Meme")
    expect(page).to have_content("Woohoo! Meme added")
    expect(meme.image.url).not_to eq ""
	end
end
