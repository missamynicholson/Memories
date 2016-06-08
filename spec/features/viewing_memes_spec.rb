feature "viewing the memes" do
  before do
    meme = create :meme
    meme2 = create :meme, top_caption: "Top2", id: 2, created_at: Time.new(2016,6,8)
  end

  scenario "shows a meme on the homepage" do
    visit '/'
    expect(page).to have_content("When you realise Adam is on master branch")
    expect(page).to have_content("and he's trying to push to github")
    expect(page).to have_css("img[src*='master-branch.jpg']")
  end

  scenario "shows multiple memes on the homepage" do
    visit '/'
    expect(page).to have_content("When you realise Adam is on master branch")
    expect(page).to have_content("Top2")
  end

  scenario "shows multiple memes on the homepage in reverse chrono order" do
    visit '/'
    first_meme_index = page.body.index("When you realise Adam is on master branch")
    second_meme_index = page.body.index("Top2")
    expect(first_meme_index).to be > second_meme_index
  end
end
