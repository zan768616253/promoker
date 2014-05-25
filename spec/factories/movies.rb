FactoryGirl.define do
	factory :movie do
		title { Faker::Lorem.sentence }
		desc { Faker::Lorem.paragraph }
		short_desc { Faker::Name.name }
		thumb { Faker::Internet.url }
		duration { Faker::Lorem.word }
		summary { Faker::Lorem.paragraph }
		url { Faker::Internet.url }
	end
end