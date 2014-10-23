require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :user_movies
  has_many :movies, through: :user_movies

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
    save
  end

  def pending_movies
    pending_movies = []
    self.movies.each do |movie|
      join = UserMovie.where(movie_id: movie.id, user_id: self.id)[0]
      if join.completed == false
        pending_movies << movie
      end
    end
    pending_movies
  end
end