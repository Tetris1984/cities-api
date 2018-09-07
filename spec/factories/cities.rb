FactoryBot.define do
  factory :city do
    name { Faker::StarWars.character }
    country_id nil
  end
end
