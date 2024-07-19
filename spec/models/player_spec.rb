require "rails_helper"

RSpec.describe Player, type: :model do
  it "is valid with valid attributes" do
    gender = Gender.create(name: "Male")
    player = Player.new(email: "test@example.com", password: "password", age: 25, gender: gender)
    expect(player).to be_valid
  end

  it "is not valid without an email" do
    player = Player.new(password: "password123", age: 25)
    expect(player).to_not be_valid
  end

  it "is not valid without a password" do
    player = Player.new(email: "test@example.com", age: 25)
    expect(player).to_not be_valid
  end

  it "is not valid without a gender" do
    player = Player.new(email: "test@example.com", password: "password", age: 25)
    expect(player).to_not be_valid
  end
end
