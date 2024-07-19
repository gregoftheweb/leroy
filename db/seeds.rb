require "faker"

# Clear existing offers
Offer.delete_all

# Fetch all Gender IDs
gender_ids = Gender.pluck(:id)

# Define an array of monster titles and their descriptions
monsters = [
  { title: "Kobolds", description: "A dark dungeon filled with traps and treasures", payout: rand(50..150) },
  { title: "Orcs", description: "An orc camp with hidden gems and weapons", payout: rand(200..500) },
  { title: "Mind Flayers", description: "A mysterious lair with ancient artifacts and gold", payout: rand(500..1000) },
  { title: "Dragons", description: "A dragon’s mountain hoard of unimaginable wealth", payout: rand(1000..5000) },
  { title: "Ghouls", description: "An abandoned graveyard with cursed relics and eerie secrets", payout: rand(75..200) },
  { title: "Giants", description: "A towering fortress of giants with colossal treasure", payout: rand(600..1500) },
  { title: "Vampires", description: "A haunted castle filled with dark secrets and valuable artifacts", payout: rand(800..2000) },
  { title: "Liches", description: "An ancient crypt with powerful magical items and riches", payout: rand(1000..3000) },
  { title: "Beholders", description: "A hidden lair of the beholders with strange and valuable treasures", payout: rand(1200..3500) },
  { title: "Trolls", description: "A swampy hideout of trolls with strange and rare items", payout: rand(200..800) },
]

# Create 100 offers with random attributes
100.times do
  monster = monsters.sample
  Offer.create(
    title: monster[:title],
    description: monster[:description],
    payout: monster[:payout],
    status: ["unassigned", "claimed", "completed", "returned"].sample(1),
    age_range: ["0-18", "19-25", "25-35", "35-45", "55 and up"].sample(1),
    gender_id: gender_ids.sample,
    player_id: nil,
  )
end
