namespace :db do
  desc "Populate users"
  task users: :environment do
    100.times do |i|
      User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: 'secret',
        password_confirmation: 'secret'  
      )
    end
  end
end