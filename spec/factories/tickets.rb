FactoryGirl.define do
	factory :ticket do
		title { Faker::Lorem.sentence }
		contact { Faker::Lorem.sentence }
		association :user
	end
end