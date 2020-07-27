require 'rails_helper'

describe 'movies model' do
  describe 'movie ratings' do
    it 'should return a list of all ratings' do
      expect(Movie.all_ratings).to eq('G PG PG-13 NC-17 R'.split(' '))
    end
  end

  describe 'similar directors' do
    before :each do
      Movie.create :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'
      Movie.create :title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'
      Movie.create :title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25'
      Movie.create :title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'
    end

    it 'should return all movies with similar directors' do
      movie = Movie.find_by(:title => 'THX-1138')

      expect(Movie.same_director(movie.director).size).to be 2
    end

    it 'should return nothing if no director' do
      movie = Movie.find_by(:title => 'Alien')

      expect(Movie.same_director(movie.director).size).to be 0
    end
  end
end