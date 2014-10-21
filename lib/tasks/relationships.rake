namespace :db do
  desc "Create user relationships"
  task user_rel: :environment do
    user = User.first
    users = User.all
    users[1..50].each do |follower|
      user.followers << follower
    end
    users[10..60].each do |following|
      user.followings << following
    end
  end
end