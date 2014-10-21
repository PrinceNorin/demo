namespace :db do
  desc "Populate entries"
  task entries: :environment do
    user = User.first
    100.times do
      user.entries.create(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph
      )
    end
  end
end