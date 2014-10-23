require 'faker'

5.times do
  User.create :username => Faker::Internet.user_name, :password => 'password'
end

