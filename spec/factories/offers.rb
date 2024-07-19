# spec/factories/offers.rb
FactoryBot.define do
  factory :offer do
    title { "Example Monster" }
    description { "A description of the offer." }
    payout { rand(100..1000) } # Random payout between 100 and 1000
    status { ["unassigned", "claimed", "completed", "returned"].sample }
    age_range { ["0-18", "19-25", "25-35", "35-45", "55 and up"].sample(1) }
    association :gender  # This creates a Gender record for the offer
    player_id { nil } # You can set this to a valid player ID if needed
  end
end
