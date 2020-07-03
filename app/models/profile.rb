class Profile < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :first_name, :family_name, presence: true,
    format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: '名前は全角で入力してください。'}
  
  validates :first_name_kana, :family_name_kana, presence: true,
    format: {with: /\A[ぁ-んー－]+\z/, message: 'ひらがなで入力してください。'}
              
  validates :birthday, presence: true
end
