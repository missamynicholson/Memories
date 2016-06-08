require 'spec_helper'

describe Meme, type: :model do

	it "should validate presence of raw_image_url" do
		meme = Meme.create(raw_image_url: "")
	  expect(meme.valid?).to eq false
	end

end