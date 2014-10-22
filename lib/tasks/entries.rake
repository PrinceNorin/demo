namespace :db do
  desc "Populate entries"
  task entries: :environment do
    # generate follow users entries
    # for testing login user and following users's
    # entries retrival
    users = User.limit(10)
    60.times do
      users.each do |user|
        user.entries.create(
          title: Faker::Lorem.sentence,
          body: Faker::Lorem.paragraph
        )
      end
    end
    
    # generate not follow users entries
    # for testing all entries retrival
    # to make it differnce from login user
    # latest entries on the home page
    others = User.find([60,70,80,90])
    60.times do
      others.each do |other|
        other.entries.create(
          title: Faker::Lorem.sentence,
          body: Faker::Lorem.paragraph
        )
      end
    end
  end
end