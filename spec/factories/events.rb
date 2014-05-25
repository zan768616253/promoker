#encoding: utf-8
FactoryGirl.define do
	factory :event do
		title { Faker::Lorem.sentence }
		content { Faker::Lorem.paragraph }
		thumb { Faker::Internet.url }
		summary { Faker::Lorem.paragraph }
		start_time 8.day.since
    	end_time 9.days.since

		trait :finished do
      		start_time 8.day.ago
      		end_time 7.days.ago
    	end

    	trait :filmfest do
    		after(:create) { |e| e.update_attributes(tag_list: '电影节') }
    	end
	end
end