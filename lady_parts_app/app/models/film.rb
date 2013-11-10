class Film < ActiveRecord::Base
  include HTTParty
  default_params output: 'json'
  format :json


# first, look in the db to see if the movie already exists

new_film = Film.find_or_initialize_by(imdb_id)
new_film.update_attributes({
  title: "movies"["title"]
  director: "alternate_ids"["imdb"]
  tomatoes_id: "movies"["id"]
  })


def self.create_tomato_movie_by_imdb_id(imdb_id)
  self.update(imdb_id, {
    title: "movies"["title"]
    director: "alternate_ids"["imdb"]
    tomatoes_id: "movies"["id"]
    })
end

def self.create_tomato_movie_by_title(title)
  self.update(title, {
    title: "movies"["title"]
    director: "alternate_ids"["imdb"]
    tomatoes_id: "movies"["id"]
    })
end

 # Bechdel Test API methods using HTTParty

# then, if it doesn't, we can get all the movie id's
# this will only be used the first time, and then again weekly?

  def self.get_all_movie_ids
    get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

  def self.get_movie_by_imdb_id(imdb_id)
    bechdel_movie = get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {title: imdb_id, output: 'json'})
    bechdel_movie.save
  end

# if the search is coming from user interaction, call api once
# for both bechdel test and rotten tomatoes 

  def self.get_movies_by_title(title) # returns any movie that matches, can be more than one
    get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title, output: 'json'})
  end
  


  # Rotten Tomatoes API methods using HTTParty



  def self.get_tomato_movie_by_imdb_id(imdb_id)
    get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id, output: 'json'})
  end

  def self.get_tomato_movie_by_title(title)
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title, output: 'json'})
  end


end
