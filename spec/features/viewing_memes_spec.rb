feature "viewing the memes" do
  before do
    meme = create :meme
  end
  context "can see memes" do
    scenario "shows a meme on the homepage" do
      visit '/'
      expect(page).to have_content("When you realise Adam is on master branch")
      expect(page).to have_content("and he's trying to push to github")
      expect(page).to have_content("master-branch.jpg")
      # expect(page).to have_css("img[src*='master-branch.jpg']")
    end
  end
end
