class Film < ActiveRecord::Base
  include HTTParty
  format :json
### first, look in the db to see if the movie already exists

  def self.from_input(imdb_id) # this should be used only by us in the beginning
    where(imdb_id).first || get_movie_by_imdb_id
    # if self(imdb_id).exists?
        # get_totmato_movie_by_imdb_id
    # else
        # get_movie_by_imdb_id(imdb_id)
        # get get_totmato_movie_by_imdb_id(imdb_id)
    #  end
  end

  def self.from_input(title) # this should be used when we allow user input
    where(title).first || get_movies_by_title
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
  def self.get_movies_by_title(title) # returns any movie that matches, can be more than one
    get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title, output: 'json'})
  end

  def self.get_totmato_movie_by_imdb_id(imdb_id)
    get('', query: {title: imdb_id, output: 'json'})
  end

  def self.get_totmato_movie_by_title
     get('', query: {title: title, output: 'json'})
  end

end
