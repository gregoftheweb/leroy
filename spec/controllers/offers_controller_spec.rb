require "rails_helper"

RSpec.describe OffersController, type: :controller do
  let(:gender_male) { Gender.create(name: "Male") }
  let(:gender_female) { Gender.create(name: "Female") }
  let(:player) { Player.create(email: "test@example.com", password: "password", age: 25, gender: gender_male) }
  let(:offer_matching) { Offer.create(title: "Matching Offer", description: "A matching offer", payout: 100.00, status: ["unassigned"], age_range: ["19-30"], gender: gender_male) }
  let(:offer_different_gender) { Offer.create(title: "Different Gender Offer", description: "A different gender offer", payout: 100.00, status: ["unassigned"], age_range: ["19-30"], gender: gender_female) }
  let(:offer_outside_age_range) { Offer.create(title: "Outside Age Range Offer", description: "An outside age range offer", payout: 100.00, status: ["unassigned"], age_range: ["30-40"], gender: gender_male) }

  before do
    sign_in player
  end

  describe "GET #index" do
    context 'when filter is "player"' do
      before do
        offer_matching
        offer_different_gender
        offer_outside_age_range
        get :index, params: { filter: "player" }
      end

      it 'includes offers matching the player\'s gender and age' do
        expect(assigns(:offers)).to include(offer_matching)
      end

      it "does not include offers with a different gender" do
        expect(assigns(:offers)).not_to include(offer_different_gender)
      end

      it 'does not include offers outside player\'s age range' do
        expect(assigns(:offers)).not_to include(offer_outside_age_range)
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested offer to @offer" do
      get :show, params: { id: offer_matching.id }
      expect(assigns(:offer)).to eq(offer_matching)
    end
  end

  describe "PATCH #claim" do
    context "when player is signed in" do
      context "with a valid offer" do
        it "claims the offer" do
          patch :claim, params: { id: offer_matching.id }
          offer_matching.reload
          expect(offer_matching.player).to eq(player)
          expect(offer_matching.status).to include("claimed")
          expect(response).to redirect_to(offers_path)
          expect(flash[:notice]).to eq("Offer was successfully claimed.")
        end
      end

      context "with an invalid offer" do
        it "does not claim the offer" do
          allow_any_instance_of(Offer).to receive(:update).and_return(false)
          patch :claim, params: { id: offer_matching.id }
          expect(response).to redirect_to(offers_path)
          expect(flash[:alert]).to eq("Failed to claim the offer.")
        end
      end
    end

    context "when player is not signed in" do
      before do
        sign_out player
      end

      it "redirects to sign in page" do
        patch :claim, params: { id: offer_matching.id }
        expect(response).to redirect_to(new_player_session_path)
        expect(flash[:alert]).to eq("You need to sign in to claim an offer.")
      end
    end
  end

  describe "PATCH #drop" do
    context "when player is signed in" do
      before do
        offer_matching.update(player: player, status: ["claimed"])
      end

      context "with a valid offer" do
        it "drops the offer" do
          patch :drop, params: { id: offer_matching.id }
          offer_matching.reload
          expect(offer_matching.player).to be_nil
          expect(offer_matching.status).to include("returned")
          expect(response).to redirect_to(offers_path)
          expect(flash[:notice]).to eq("Offer was successfully dropped.")
        end
      end

      context "with an invalid offer" do
        it "does not drop the offer" do
          allow_any_instance_of(Offer).to receive(:update).and_return(false)
          patch :drop, params: { id: offer_matching.id }
          expect(response).to redirect_to(offers_path)
          expect(flash[:alert]).to eq("Failed to drop the offer.")
        end
      end
    end

    context "when player is not signed in" do
      before do
        sign_out player
      end

      it "redirects to sign in page" do
        patch :drop, params: { id: offer_matching.id }
        expect(response).to redirect_to(new_player_session_path)
        expect(flash[:alert]).to eq("You need to sign in to claim an offer.")
      end
    end
  end
end
