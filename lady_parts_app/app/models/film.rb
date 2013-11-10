class Film < ActiveRecord::Base
  include HTTParty
  default_params output: 'json'
  format :json



def self.create_bechdel_movies
  movies = Film.get_all_movie_ids
  movies.each do |movie|
    film = Film.where(imdb_id: movie["imdbid"]).first || Film.create(imdb_id: movie["imdbid"], bechdel_id: movie["id"] )
  end
end

def self.add_tomatoes_movies
  movies = Film.all
  movies.each do |movie|
    if get_tomato_movie_by_imdb_id(movie.imdb_id)
      
      tomato_movie = movie.get_tomato_movie_by_imdb_id(movie.imdb_id)
      
      movie.update(movie.imdb_id, 
          movie.title = tomato_movie["title"], 
          movie.director = tomato_movie["abridged_directors"][0]["name"], 
          movie.tomatoes_id = tomato_movie["id"])
    else
      "you got to line 25"
    end
  end
end

# def self.add_bechdel_ratings
#   movies = Film.all
#   movies.each do |movie|
#     bechdel_rating = movie.get_movie_by_imdb_id(movie.imdb_id)
# end
 # Bechdel Test API methods using HTTParty

# then, if it doesn't, we can get all the movie id's
# this will only be used the first time, and then again weekly?

  def self.get_all_movie_ids
    all_bechdel_films = get('http://bechdeltest.com/api/v1/getAllMovieIds')
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
    tomato_movie_json = get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id, output: 'json'})
    tomato_film_by_imdb_id = JSON.parse(tomato_movie_json)

  end

# this won't return directors
  def self.get_tomato_movie_by_title(title)
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title, output: 'json'})
  end


end
