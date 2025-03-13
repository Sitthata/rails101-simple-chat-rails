require 'rails_helper'

describe RoomsController do
  describe "POST #create" do
    it "creates a room" do
      post :create, params: { room: { name: "Test Room", description: "This is a test room." } }
      expect(response).to have_http_status(:success)
    end
  end
end
