feature 'Posting meme' do

	after do
		remove_uploaded_file
	end

  scenario 'user can update a meme to add a memeified image' do
    allow(Cloudinary::Uploader).to receive(:upload).and_return({"test_url" => 'test',"public_id" => 'test_id'})
		allow(Cloudinary::Utils).to receive(:cloudinary_url).and_return('transform_info')
		sign_up
		search
    click_link('0')
    fill_in("Top caption", with: "Hi, Adam")
    fill_in("Bottom caption", with: "Bye Adam")
    meme = Meme.find_by(raw_image_url: 'http://google.com/images/test')
    allow_any_instance_of(Meme).to receive(:memeify).and_return(meme.image = (Rails.root + 'spec/files/images/confused_dog.png').open)
    click_button("Update Meme")
    expect(page).to have_content("Woohoo! Meme added")
		expect(page).to have_content("by myUsername")
    expect(meme.image.url).to match(/confused_dog.png/)
	end

	scenario 'user cancels meme creation midway through' do
    allow(Cloudinary::Uploader).to receive(:upload).and_return({"test_url" => 'test',"public_id" => 'test_id'})
		allow(Cloudinary::Utils).to receive(:cloudinary_url).and_return('transform_info')
		sign_up
		search
    click_link('0')
    meme = Meme.find_by(raw_image_url: 'http://google.com/images/test')
    click_link("Cancel")
    expect(page).not_to have_css("img[src*='confused_dog.png']")
		expect(current_path).to eq memes_path
    expect(Meme.all.count).to equal(0)
	end

end
