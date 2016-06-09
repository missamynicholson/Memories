feature "viewing the memes" do
  before do
    sign_up
    user = create :user
    meme = Meme.create(raw_image_url: "url", image: (Rails.root + 'spec/files/images/confused_dog.png').open, created_at: Time.new(2016,6,7), user: user)
    meme1 = Meme.create(raw_image_url: "url", image: (Rails.root + 'spec/files/images/master-branch.jpg').open, created_at: Time.new(2016,6,8), user: user)
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

  scenario "shows multiple memes on the homepage in reverse chrono order" do
    visit '/'
    first_meme_index = page.body.index("master-branch.jpg")
    second_meme_index = page.body.index("confused_dog.png")
    expect(first_meme_index).to be < second_meme_index
  end
end
