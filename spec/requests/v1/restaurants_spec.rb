require 'rails_helper'

RSpec.describe "V1::Restaurants", type: :request do
  describe "GET /v1/restaurants" do
    let!(:restaurants) do
      create_list(:restaurant, 3)
    end

    it "returns http success" do
      get "/v1/restaurants"

      expect(response).to have_http_status(:success)
    end

    it "returns collections of restaurants" do
      get "/v1/restaurants"

      expect(JSON.parse(response.body)).to eq(RestaurantSerializer.new(restaurants).serializable_hash.as_json)
    end

    context "with search keyword(s)" do
      before do
        create(:restaurant, name: "burger kong", email: "burger.kong@example.com")
        create(:restaurant, name: "mac burger", email: "mac.burger@example.com")
      end

      it "returns matched restaurant(s)" do
        get "/v1/restaurants", params: { name: "burger", email: "example.com" }

        json_response = JSON.parse(response.body)
        expect(json_response["data"].length).to eq(2)
      end
    end
  end

  describe "POST /v1/restaurants" do
    context "with valid params" do
      let(:valid_params) do
        { restaurant: build(:restaurant).attributes }
      end

      it "creates a new restaurant" do
        expect {
          post "/v1/restaurants", params: valid_params
        }.to change { Restaurant.count }.by(1)
      end

      it "returns http success" do
        post "/v1/restaurants", params: valid_params

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        { restaurant: build(:restaurant, name: "").attributes }
      end

      it "returns error response" do
        post "/v1/restaurants", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create new restaurant" do
        expect {
          post "/v1/restaurants", params: invalid_params
        }.not_to change { Restaurant.count }
      end
    end
  end

  describe "GET /v1/restaurants/:id" do
    context "when restaurant exists" do
      let!(:restaurant) { create(:restaurant) }

      it "returns http success" do
        get "/v1/restaurants/#{restaurant.id}"

        expect(response).to have_http_status(:success)
      end

      it "returns detail of a restaurant" do
        get "/v1/restaurants/#{restaurant.id}"

        expect(JSON.parse(response.body)).to eq(RestaurantSerializer.new(restaurant).serializable_hash.as_json)
      end
    end

    context "when restaurant does not exist" do
      it "returns http not_found" do
        get "/v1/restaurants/1"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT /v1/restaurants/:id" do
    context "when restaurant exists" do
      let!(:restaurant) { create(:restaurant) }

      context "when update success" do
        let(:valid_params) do
          {
            restaurant: { name: "updated restaurant" }
          }
        end

        it "returns http success" do
          put "/v1/restaurants/#{restaurant.id}", params: valid_params

          expect(response).to have_http_status(:success)
        end

        it "updates a restaurant" do
          expect {
            put "/v1/restaurants/#{restaurant.id}", params: valid_params
          }.to change { restaurant.reload.name }
        end
      end

      context "when update failed" do
        let(:invalid_params) do
          {
            restaurant: { name: "" }
          }
        end

        it "returns http error" do
          put "/v1/restaurants/#{restaurant.id}", params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "does not update restaurant" do
          expect {
            put "/v1/restaurants/#{restaurant.id}", params: invalid_params
          }.not_to change { restaurant.reload.name }
        end
      end
    end

    context "when restaurant does not exist" do
      it "returns http not_found" do
        put "/v1/restaurants/1", params: { restaurant: {} }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /v1/restaurants/:id" do
    context "when delete success" do
      let!(:restaurant) { create(:restaurant) }

      it "returns http success" do
        delete "/v1/restaurants/#{restaurant.id}"

        expect(response).to have_http_status(:success)
      end

      it "deletes a restaurant" do
        expect {
          delete "/v1/restaurants/#{restaurant.id}"
        }.to change { Restaurant.count }.by(-1)
      end
    end

    context "when restaurant does not exist" do
      it "returns http not_found" do
        delete "/v1/restaurants/1"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
