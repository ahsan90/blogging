require 'spec_helper'

describe "User Pages" do
  subject {page}
  describe "Signup page" do
   before{ visit signup_path}
   it { should have_content('Sign up')}
    it { should have_title(full_title('Sign up'))}
  end
  describe "Signup" do
    before{ visit signup_path}
    let(:submit) { "Create my account" }
    describe "with invalid information" do
      it "should not create user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end
    describe "with valid information" do
      before do
        fill_in "Name", with: "Test User"
        fill_in "Email", with: "Testmail@gmail.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end
    end
  end

  describe "Profile page" do
    let(:user) {FactoryGirl.create (:user)}
    before{ visit user_path(user)}
    it{ should have_content(user.name)}
    it { should have_title(user.name)}
  end
end

