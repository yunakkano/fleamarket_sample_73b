class SelfIntroduction < ApplicationRecord
    belongs_to :user
    validates :introduction, presence: true
end
