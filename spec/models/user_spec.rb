describe User, type: :model do

  describe "users" do

    it "has correct association with post" do
      should have_many :memes
    end
  end
end
