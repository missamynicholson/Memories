feature "deleting memes" do

  let!(:user) { FactoryGirl.create(:user)}
  let!(:meme) {FactoryGirl.create(:meme, user: user)}

  before do
    user2 = FactoryGirl.create(:user, email: "amy2@gmail.com",
                                      username: "amynic2", id: 2)
    meme2 = FactoryGirl.create(:meme, user: user2, id: 2)
    log_in
  end

  context "when user created meme" do
    scenario "can delete the meme" do
      find("a[href='#{meme_path(1)}']").click
      expect(page).to have_content "Your meme was successfully deleted!"
      expect(page).not_to have_content "confused_dog.png"
      expect(Meme.all.count).to equal(1)
    end
  end

  context "when user didn't create meme" do
    scenario "can't delete the meme" do
      expect(page).not_to have_css("a[href='#{meme_path(2)}']")
      expect(Meme.all.count).to equal(2)
    end

    scenario "cannot delete the meme via url path" do
      page.driver.submit :delete, "memes/2", {}
      expect(page.current_path).to eq root_path
      expect(page).to have_content("That meme doesn't belong to you!")
      expect(Meme.all.count).to equal(2)
    end
  end


  scenario "can't delete the meme (for some unknown reason)" do
    allow_any_instance_of(Meme).to receive(:destroy).and_return false
    find("a[href='#{meme_path(1)}']").click
    expect(page).to have_content "Uh oh! Couldn't delete your meme!"
    expect(page).to have_css("img[src*='confused_dog.png']")
    expect(Meme.all.count).to equal(2)
  end
end
