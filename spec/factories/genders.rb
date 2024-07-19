# spec/factories/genders.rb
FactoryBot.define do
  factory :gender do
    name { ["Male", "Female", "Non-binary", "Other"].sample }
  end
end
