require "rails_helper"

RSpec.describe "Offers", type: :request do
  let!(:offers) { create_list(:offer, 10) }  # Assumes you have a factory for offers

  describe "GET /offers" do
    it "returns a successful response" do
      get offers_path
      expect(response).to have_http_status(:ok)
    end

    it "displays a list of offers" do
      get offers_path
      offers.each do |offer|
        expect(response.body).to include(offer.title)
        expect(response.body).to include(offer.description)
        expect(response.body).to include(offer.payout.to_s)
        expect(response.body).to include(offer.status.join(", "))
        expect(response.body).to include(offer.age_range.join(", "))
      end
    end
  end
end
