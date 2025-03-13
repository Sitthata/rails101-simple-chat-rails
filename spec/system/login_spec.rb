require 'rails_helper'

describe "User can login to chat app", type: :system do
  context "user exists" do
    before { create(:user) }

  it "allows a user to login" do
    user_goes_to_login_page
    user_enters_email_and_password
    user_clicks_login_button
    user_should_see_chatroom_page
  end

  it "does not allow anonymous users to login" do
  end

  it "check user's email and password" do
  end

  def user_goes_to_login_page
    visit "/users/sign_in"
  end

  def user_enters_email_and_password
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "john123"
  end

  def user_clicks_login_button
    click_button "Log in"
  end

  def user_should_see_chatroom_page
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_current_path("/")
    save_and_open_screenshot
    # expect(page).to have_content("Create Room")
  end
end
end
