FactoryGirl.define do
	factory :article do
		title { Faker::Lorem.sentence }
		body { Faker::Lorem.paragraph }
		author { Faker::Name.name }
		thumb { Faker::Internet.url }
		summary { Faker::Lorem.paragraph }
	end
end