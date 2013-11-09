class Film < ActiveRecord::Base
  include HTTParty
  format: json

  def self.get_all_movie_ids
    get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

  def self.get_movies_by_title(title)
    get('http://bechdeltest.com/api/v1/getMoviesByTitle', :query => {:title => title, :output => 'json'})
  end

  def self.get_movie_by_imdb_id(imdb_id)
    get('http://bechdeltest.com/api/v1/getMovieByImdbId', :query => {:imdb_id => imdb_id, :output => 'json'})
  end

end
