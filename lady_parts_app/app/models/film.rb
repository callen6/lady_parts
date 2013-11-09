class Film < ActiveRecord::Base
  include HTTParty
  format :json
### first, look in the db to see if the movie already exists
  def self.from_

  end
### then, if it doesn't, we can get all the movie id's
### this will only be used the first time, and then again weekly?
  def self.get_all_movie_ids
    get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

  def self.get_movie_by_imdb_id(imdb_id)
    get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {title: imdb_id, output: 'json'})
  end

### if the search is coming from user interaction, call api once
### for both bechdel test and rotten tomatoes 
  def self.get_movies_by_title(title)
    get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title, output: 'json'})
  end

  def self.get_totmato_movie_by_imdb_id(imdb_id)
    get('', query: {title: imdb_id, output: 'json'})
  end

  def self.get_totmato_movie_by_title
     get('', query: {title: title, output: 'json'})
  end

end
