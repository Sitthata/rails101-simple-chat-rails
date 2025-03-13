require 'rails_helper'

RSpec.describe "#Create Room", type: :system do
  context "user already login" do
    let(:user) { create(:user) }

    before do
      driven_by(:selenium_chrome_headless)
      user_login
      create(:room, name: "Odts New Room", description: "This is a test room.")
      save_and_open_screenshot
    end

    it "allow user to create a room" do
      user_goes_to_rooms_page
      user_enter_room_name
      user_click_create_room
      user_should_see_new_room
    end

    after do
      Warden.test_reset!
    end
  end

  def user_login
    user = create(:user, email: "john@example.com", password: "john123")
    puts "Created user: #{user.inspect}"

    visit "/users/sign_in"
    puts "Current path: #{current_path}"
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "john123"
    click_button "Log in"

    puts "After login path: #{current_path}"
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
