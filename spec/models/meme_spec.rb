require 'spec_helper'

describe Meme, type: :model do

	after do
		remove_uploaded_file
	end

	it "has correct association with user" do
      should belong_to :user
    end

	it "should validate presence of raw_image_url" do
		meme = Meme.create(raw_image_url: "")
	  expect(meme.valid?).to eq false
	end

	it "should return the memeified image" do
		meme = Meme.create(raw_image_url: "http://google.com/images/test")
		allow(URI).to receive(:parse).and_return((Rails.root + 'spec/files/images/confused_dog.png').open)
		meme.memeify("url")
		expect(meme.image.path).to match(/confused_dog.png/)
	end

end
