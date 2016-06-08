FactoryGirl.define do
  factory :meme do
    top_caption "When you realise Adam is on master branch"
    bottom_caption "and he's trying to push to github"
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/master-branch.jpg', 'image/jpg')
  end
end