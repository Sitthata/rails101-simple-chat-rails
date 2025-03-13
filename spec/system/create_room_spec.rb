require 'rails_helper'

RSpec.describe "#Create Room", type: :system do
  context "user already login" do
    let(:user) { create(:user) }

    before do
      Warden.test_mode!
      create(:room, name: "Existing Room", description: "This is an existing room.")
      login_as(user, scope: :user)
    end

    after do
      Warden.test_reset!
    end

    it "allows a user to create a room" do
      user_goes_to_rooms_page
      user_enter_room_name
      user_click_create_room
      user_should_see_new_room
    end
  end

  def user_login
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    # login_as(user, scope: :user)
    # visit "/"
    # save_and_open_screenshot
  end

  def user_goes_to_rooms_page
    visit "/rooms"
    save_and_open_screenshot
  end

  def user_enter_room_name
    fill_in "Name", with: "Odts New Room"
    save_and_open_screenshot
  end

  def user_click_create_room
    click_button "Create Room"
  end

  def user_should_see_new_room
    expect(page).to have_content("Odts New Room")
    save_and_open_screenshot
  end
end
