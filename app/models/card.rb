class Card < ApplicationRecord

  validates :user_id, presence: true
  validates :customer_id, presence: true
  validates :card_id, presence: true
end
