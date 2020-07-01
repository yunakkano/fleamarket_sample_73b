class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :first_name, :family_name, 
            :first_name_kana, :family_name_kana, 
            :birthday, presence: true
end
