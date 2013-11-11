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
  # binding.pry
  movies.each do |movie|
      tomato_movie = movie.get_tomato_movie_by_imdb_id('movie.imdb_id')
      if tomato_movie["error"] == "Could not find a movie with the specified id" 
          movie.title = "No record in Rotten Tomatoes" 
          movie.director = "No record in Rotten Tomatoes"  
          movie.tomatoes_id = "No record in Rotten Tomatoes"
      else 
          movie.title = tomato_movie["title"]
          movie.director = tomato_movie["abridged_directors"][0]["name"]
          movie.tomatoes_id = tomato_movie["id"]
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
  # class method
  def self.get_all_movie_ids
    all_bechdel_films = get('http://bechdeltest.com/api/v1/getAllMovieIds')
  end

  def get_movie_by_imdb_id(imdb_id)
    Film.get('http://bechdeltest.com/api/v1/getMovieByImdbId', query: {title: imdb_id})
  end

# if the search is coming from user interaction, call api once
# for both bechdel test and rotten tomatoes 

  def get_movies_by_title(title) # returns any movie that matches, can be more than one

    Film.get('http://bechdeltest.com/api/v1/getMoviesByTitle', query: {title: title})

  end
  


  # Rotten Tomatoes API methods using HTTParty

  # if we take away self, we have to put in Film
  def get_tomato_movie_by_imdb_id(imdb_id)
   Film.get('http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=' + ENV['API_KEY'] + '&type=imdb&id=' + imdb_id, query: {imdb_id: imdb_id})


  end

# this won't return directors
  def get_tomato_movie_by_title(title)
    #uri encoding in ruby http://www.ruby-doc.org/stdlib-2.0.0/libdoc/uri/rdoc/URI/Escape.html
    enc_title = URI.escape(title)
    Film.get('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=' + ENV['API_KEY'] + '&q=' + enc_title + '&page_limit=1', query: {title: title})
  end


end
