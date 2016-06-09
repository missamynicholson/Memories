feature "viewing the memes" do
  before do
    meme = Meme.create(raw_image_url: "url", image: (Rails.root + 'spec/files/images/confused_dog.png').open)
    meme1 = Meme.create(raw_image_url: "url", image: (Rails.root + 'spec/files/images/master-branch.jpg').open)
  end

  after do
		remove_uploaded_file
	end

  scenario "shows a meme on the homepage" do
    visit '/'
    expect(page).to have_css("img[src*='master-branch.jpg']")
  end

  scenario "shows multiple memes on the homepage" do
    visit '/'
    expect(page).to have_css("img[src*='master-branch.jpg']")
    expect(page).to have_css("img[src*='confused_dog.png']")
  end
end
