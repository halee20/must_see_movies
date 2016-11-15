class Bookmark < ApplicationRecord
  validates :user_id, :presence => true
  validates :movie_id, :presence => true, :uniqeness => {:scope =}
end
