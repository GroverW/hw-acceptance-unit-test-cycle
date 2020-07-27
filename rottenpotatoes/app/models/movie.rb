class Movie < ActiveRecord::Base
  scope :same_director, ->director { where(director: director).where.not(director: [nil, '']) }

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end
