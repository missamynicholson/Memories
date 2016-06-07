feature "login and logout" do
  before do
    user = create :user
  end
  feature "login" do
    context "when correct credentials" do
      scenario "login correctly" do
        log_in
        expect(page).to have_content("amynic")
        expect(page).to have_content("Logged in successfully.")
      end
    end

    context "when credentials are incorrect" do
      scenario "do not login if wrong password" do
        log_in(email: "amy@gmail.com", password: "wrong password")
        expect(page).to have_content("Invalid Email or password")
      end

      scenario "do not login if wrong email" do
        log_in(email: "incorrect@gmail.com", password: "testtest")
        expect(page).to have_content("Invalid Email or password")
      end
    end
  end

  feature "logout" do
    scenario "logout" do
      log_in
      click_link "Logout"
      expect(page).not_to have_link "Logout"
      expect(page).to have_link "Login"
      #when not logged in, shouldn't be able to create a new meme
    end
  end


  feature "sign-up" do
    context "valid credentials" do
      scenario "signs up with valid credentials" do
        sign_up("whatwhat")
        expect(page).not_to have_link "Login"
        expect(page).to have_link "Logout"
      end
    end

    context "invalid credentials" do
      scenario "sign-up with too short a user name" do
        sign_up("pee")
        expect(page).not_to have_link "Logout"
        expect(page).to have_link "Login"
        expect(page).to have_content "Username is too short (minimum is 4 characters)"
      end

      scenario "sign-up with long a user name" do
        sign_up("peeeeeeeeeeeeweeeeeeeeeeeeeeeeeeeeeeeeeeeee")
        expect(page).not_to have_link "Logout"
        expect(page).to have_link "Login"
        expect(page).to have_content "Username is too long (maximum is 16 characters)"
      end

      scenario "sign-up without supplying a user name" do
        sign_up(nil)
        expect(page).not_to have_link "Logout"
        expect(page).to have_link "Login"
        expect(page).to have_content "Username can't be blank"
      end

      scenario "sign-up with a user name that already exists" do
        sign_up("HelloBuddy")
        click_link "Logout"
        sign_up("HelloBuddy")
        expect(page).not_to have_link "Logout"
        expect(page).to have_link "Login"
        expect(page).to have_content "Username has already been taken"
      end
  end

  end
end
