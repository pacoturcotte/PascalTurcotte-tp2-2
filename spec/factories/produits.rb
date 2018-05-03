FactoryBot.define do
  factory :produit do
    nom {Faker::Lorem.word}
    quantite {Faker::Number.number(2)}
    description  {Faker::Lorem.sentence}
    prix  {Faker::Number.decimal(2, 3) }
  end
end
