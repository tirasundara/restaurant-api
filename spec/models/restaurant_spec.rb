# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "#name" do
    context "when it has a valid value" do
      it "should be valid" do
        restaurant = build(:restaurant)

        expect(restaurant).to be_valid
      end
    end

    context "when it is empty" do
      it "should be invalid" do
        restaurant = build(:restaurant, name: "")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, name: "")
        restaurant.valid?

        expect(restaurant.errors["name"]).to include("can't be blank")
      end
    end

    context "when it has a nil value" do
      it "should be invalid" do
        restaurant = build(:restaurant, name: nil)

        expect(restaurant).not_to be_valid
      end
    end
  end

  describe "#email" do
    context "when it has a valid value" do
      it "should be valid" do
        restaurant = build(:restaurant)

        expect(restaurant).to be_valid
      end
    end

    context "when it has an invalid format" do
      it "should be invalid" do
        restaurant = build(:restaurant, email: "invalid_email")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, email: "invalid_email")
        restaurant.valid?

        expect(restaurant.errors["email"]).to include("invalid email")
      end
    end

    context "when it is empty" do
      it "should be invalid" do
        restaurant = build(:restaurant, email: "")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, email: "")
        restaurant.valid?

        expect(restaurant.errors["email"]).to include("can't be blank")
      end
    end

    context "when it has a nil value" do
      it "should be invalid" do
        restaurant = build(:restaurant, email: nil)

        expect(restaurant).not_to be_valid
      end
    end

    context "when it is has a non-unique value" do
      let!(:restaurant1) { create(:restaurant, email: "resto@example.com") }

      it "should be invalid" do
        restaurant = build(:restaurant, email: restaurant1.email)

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, email: restaurant1.email)
        restaurant.valid?

        expect(restaurant.errors["email"]).to include("has already been taken")
      end
    end
  end

  describe "#phone_number" do
    context "when it has a valid value" do
      it "should be valid" do
        restaurant = build(:restaurant)

        expect(restaurant).to be_valid
      end
    end

    context "when it has an invalid format" do
      it "should be invalid" do
        restaurant = build(:restaurant, phone_number: "abc123")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, phone_number: "abc123")
        restaurant.valid?

        expect(restaurant.errors["phone_number"]).to include("is invalid")
      end
    end

    context "when it is empty" do
      it "should be invalid" do
        restaurant = build(:restaurant, phone_number: "")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, phone_number: "")
        restaurant.valid?

        expect(restaurant.errors["phone_number"]).to include("can't be blank")
      end
    end

    context "when it has a nil value" do
      it "should be invalid" do
        restaurant = build(:restaurant, phone_number: nil)

        expect(restaurant).not_to be_valid
      end
    end

    context "when it is has a non-unique value" do
      let!(:restaurant1) { create(:restaurant) }

      it "should be invalid" do
        restaurant = build(:restaurant, phone_number: restaurant1.phone_number)

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, phone_number: restaurant1.phone_number)
        restaurant.valid?

        expect(restaurant.errors["phone_number"]).to include("has already been taken")
      end
    end
  end

  describe "#address" do
    context "when it has a valid value" do
      it "should be valid" do
        restaurant = build(:restaurant)

        expect(restaurant).to be_valid
      end
    end

    context "when it is empty" do
      it "should be invalid" do
        restaurant = build(:restaurant, address: "")

        expect(restaurant).not_to be_valid
      end

      it "has an error message" do
        restaurant = build(:restaurant, address: "")
        restaurant.valid?

        expect(restaurant.errors["address"]).to include("can't be blank")
      end
    end

    context "when it has a nil value" do
      it "should be invalid" do
        restaurant = build(:restaurant, address: nil)

        expect(restaurant).not_to be_valid
      end
    end
  end
end
