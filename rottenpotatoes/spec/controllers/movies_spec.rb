require 'rails_helper'

def create_movies
  Movie.create :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'
  Movie.create :title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'
  Movie.create :title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25'
  Movie.create :title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'
end

describe MoviesController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET movie' do
    before :each do
      create_movies
    end
    it 'renders the show template' do
      movie = Movie.find_by(:title => 'THX-1138')
      get :show, :id => movie.id
      expect(response).to render_template('show')
    end
  end

  describe 'POST movie' do
    it 'redirects to index on successful creation' do
      post :create, :movie => {:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'}
      expect(response).to redirect_to('/movies')
    end
  end

  describe 'PUT movie' do
    before :each do
      create_movies
    end
    it 'redirects to movie page on successful update' do
      movie = Movie.find_by(:title => 'Alien')
      put :update, :id => movie.id, :movie => { :rating => 'R', :director => 'Ridley Scott', :release_date => '1979-05-25'}
      expect(response).to redirect_to("/movies/#{movie.id}")
    end
  end

  describe 'DELETE movie' do
    before :each do
      create_movies
    end
    it 'redirects to index page on successful delete' do
      movie = Movie.find_by(:title => 'Alien')
      post :destroy, :id => movie.id
      expect(response).to redirect_to("/movies")
    end
  end

  describe 'GET director' do
    before :each do
      create_movies
    end

    it 'renders the director template' do
      movie = Movie.find_by(:title => 'THX-1138')
      get :director, :id => movie.id
      expect(response).to render_template('director')
    end

    it 'redirects to index if no director' do
      movie = Movie.find_by(:title => 'Alien')
      get :director, :id => movie.id
      expect(response).to redirect_to('/movies')
    end
  end
end