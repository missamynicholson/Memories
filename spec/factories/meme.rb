FactoryGirl.define do
  image_path = 'spec/files/images/confused_dog.png'
  factory :meme do
    top_caption "top caption"
    bottom_caption "bottom caption"
    raw_image_url "rawImageUrl"
    image Rack::Test::UploadedFile.new(Rails.root + image_path, 'image/jpg')
    id 1
  end
end
