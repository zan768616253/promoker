FactoryGirl.define do
	factory :project do
		title { Faker::Lorem.sentence }
		description { Faker::Lorem.paragraph }
		script { Faker::Lorem.paragraph }
		team { Faker::Lorem.paragraph }
		plan { Faker::Lorem.paragraph }
		expense { Faker::Lorem.paragraph }
		cover { Faker::Internet.url }
		video { Faker::Internet.url }
		status "draft"
		association :user

		trait :published do
			status "published"
		end

	end
end