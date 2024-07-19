class Offer < ApplicationRecord
  belongs_to :gender
  belongs_to :player, optional: true
end
