FactoryBot.define do
  factory :fournisseur do
    nom {Faker::Company.name}
    adresse {"#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.country}"}
    tel  {Faker::PhoneNumber.phone_number}
  end
end
