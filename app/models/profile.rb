class Profile < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :first_name, :family_name, presence: true,
    format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は全角で入力してください。'}
  
  validates :first_name_kana, :family_name_kana, presence: true,
    format: {with: /\A[ぁ-んー－]+\z/, message: 'はひらがなで入力してください。'}
              
  validates :birthday, presence: true

  validate :birthday_before_today?

  private

  def birthday_before_today?
    return if birthday.blank?

    if birthday > Date.today
      errors.add(:birthday, "誕生日が不正です。")
    end
  end
end
