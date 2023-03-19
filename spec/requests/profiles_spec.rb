require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { users(:pete) }
  let(:other) { users(:lazaro_nixon) }

  describe "GET /:username" do
    context "when signed out" do
      it "returns http success" do
        get "/#{user.username}"
        expect(response).to have_http_status(:success)
      end
    end

    context "when signed in" do
      it "returns http success" do
        sign_in(user)
        get "/#{user.username}"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /edit" do
    before { sign_in(user) }

    it "returns http success" do
      get "/profiles/#{user.username}/edit"
      expect(response).to have_http_status(:success)
    end

    it "redirects away if you don't have permission" do
      get "/profiles/#{other.username}/edit"
      expect(response).to redirect_to(root_path)
    end
  end
end
