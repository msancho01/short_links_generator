require 'rails_helper'

RSpec.describe ShortLinksController, type: :controller do
  let(:valid_attributes) { { long_url: 'https://www.google.com', clicks_count: rand(1..50) } }
  let(:invalid_attributes) { { long_url: 'www.google' } }

  describe "GET #index" do
    it "with valid attributes" do
      ShortLink.create! valid_attributes
      get :index
      expect(response).to be_successful
    end

    it "returns the top 100 short_links ordered by clicks_count in descending order" do
      150.times { ShortLink.create! valid_attributes }
      get :index
      expect(assigns(:short_links).size).to be <= 100
      expect(assigns(:short_links)).to eq(ShortLink.order(clicks_count: :desc).limit(100))
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new ShortLink" do
        expect {
          post :create, params: { short_link: valid_attributes }, format: :json
        }.to change(ShortLink, :count).by(1)
      end

      it "returns a success response" do
        post :create, params: { short_link: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to eq(ShortLink.last.to_json)
      end
    end

    context "with invalid params" do
      it "returns an error response" do
        post :create, params: { short_link: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to eq({long_url: ["Invalid URL format", "www.google is not a valid URL"]}.to_json)
      end
    end
  end

  describe "GET #redirect" do
    it "redirects to the Long URL" do
      short_link = ShortLink.create! valid_attributes
      get :redirect, params: { token: short_link.token }
      expect(response).to redirect_to(short_link.long_url)
    end
  end
end