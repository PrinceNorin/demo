FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "norin#{i}" }
    sequence(:email) { |i| "norin_#{i}@example.com" }
    password 'secret'
    password_confirmation 'secret'
  end
  
  factory :entry do
    title 'entry'
    body 'entry one'
    user
  end
end