require 'faker'

5.times do
  User.create :username => Faker::Internet.user_name, :password => 'password'
end

5.times do
  Movie.create :title => "Star Wars", :rating => "5", :year => "1975", :summary => "Stuff happens and stuff."
end

10.times do
  UserMovie.create :user_id => rand(5), :movie_id => rand(5)
end