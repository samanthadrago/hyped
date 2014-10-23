class UserMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  # Remember to create a migration!
end
