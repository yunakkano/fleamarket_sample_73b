FactoryBot.define do
    factory :sns_credential do
      provider              {'facebook'}
      uid                   {"12345"}
      user_id               {''}
    end
end